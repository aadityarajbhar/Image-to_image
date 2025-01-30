import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;
import '../../database/database_helper.dart';
import '../../helper/ad_helper.dart';
import '../../models/product_model.dart';
import '../add_products/add_product_screen.dart';
import '../auth_screens/login_screens.dart';
import '../booking_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;
  RewardedAd? _rewardedAd;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  String? lastDownloadedPdfPath;
  String? userEmail;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await _getUserEmail();
      if (userEmail != null) {
        await _loadProducts();
      }
      _initializeAds();
      setState(() {
        _isInitialized = true;
        isLoading = false;
      });
    } catch (e) {
      dev.log('Initialization error: $e');
      setState(() {
        errorMessage = 'Failed to initialize app';
        isLoading = false;
      });
    }
  }

  void _initializeAds() {
    _initBannerAd();
    _createRewardedAd();
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      // Show confirmation dialog
      bool? confirmDelete = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.white,
            title: const Text('Confirm Delete'),
            content:
                const Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red.shade300),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        // Show loading indicator
        setState(() {
          isLoading = true;
        });

        // Delete the product from database
        final result = await DatabaseHelper.instance.deleteProduct(
          product.id!,
          userEmail!,
        );

        if (result > 0) {
          // If product has an image, delete it from storage
          if (product.image != null && product.image!.isNotEmpty) {
            final file = File(product.image!);
            if (await file.exists()) {
              await file.delete();
            }
          }

          // Update the UI
          setState(() {
            products.removeWhere((p) => p.id == product.id);
            isLoading = false;
          });

          // Show success message
          if (mounted) {
            showAnimatedToast('Product deleted successfully');
          }
        } else {
          if (mounted) {
            showAnimatedToast('Failed to delete product');
          }
        }
      }
    } catch (e) {
      print('Error deleting product: $e');
      if (mounted) {
        showAnimatedToast('Error deleting product');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _initBannerAd() {
    try {
      _bannerAd = BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            dev.log('Banner ad loaded');
            if (mounted) {
              setState(() {
                _isAdLoaded = true;
              });
            }
          },
          onAdFailedToLoad: (ad, error) {
            dev.log('Banner ad failed: ${error.message}');
            ad.dispose();
            if (mounted) {
              setState(() {
                _isAdLoaded = false;
              });
            }
            // Retry loading banner ad after delay
            Future.delayed(const Duration(seconds: 30), _initBannerAd);
          },
        ),
      );
      _bannerAd?.load();
    } catch (e) {
      dev.log('Banner ad initialization error: $e');
    }
  }

  Future<void> _getUserEmail() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email');

      if (email == null || email.isEmpty) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
        return;
      }

      setState(() {
        userEmail = email;
      });
    } catch (e) {
      dev.log('Error getting email: $e');
      throw Exception('Failed to get user email');
    }
  }

  Future<void> _loadProducts() async {
    if (!mounted) return;

    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      if (userEmail == null) {
        throw Exception('User email not available');
      }

      final db = await DatabaseHelper.instance.database;
      final productsList =
          await DatabaseHelper.instance.getAllProductsForUser(userEmail!);

      if (mounted) {
        setState(() {
          products = productsList;
          isLoading = false;
        });
      }
    } catch (e) {
      dev.log('Error loading products: $e');
      if (mounted) {
        setState(() {
          errorMessage = 'Failed to load products';
          isLoading = false;
        });
      }
    }
  }

  void _createRewardedAd() {
    try {
      RewardedAd.load(
        adUnitId: AdHelper.getRewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (error) {
            dev.log('Rewarded ad failed: ${error.message}');
            _rewardedAd = null;
            Future.delayed(const Duration(seconds: 30), _createRewardedAd);
          },
        ),
      );
    } catch (e) {
      dev.log('Rewarded ad creation error: $e');
    }
  }

  void showAnimatedToast(String message) {
    if (!mounted) return;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.h,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 50),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  void _showRewardedAd() {
    dev.log('Attempting to show Rewarded Ad');

    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          dev.log('Rewarded Ad showed full screen content');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          dev.log('Rewarded Ad was dismissed');
          ad.dispose();
          _createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          dev.log('Rewarded Ad failed to show');
          ad.dispose();
          _createRewardedAd();
          // Directly generate PDF instead of showing error toast
          _generateAndDownloadPDF();
        },
      );

      try {
        _rewardedAd!.setImmersiveMode(true);
        _rewardedAd!.show(
          onUserEarnedReward: (_, RewardItem reward) {
            _generateAndDownloadPDF();
          },
        );
        _rewardedAd = null;
      } catch (e) {
        // On error, directly generate PDF instead of showing error toast
        _generateAndDownloadPDF();
      }
    } else {
      // If ad is not ready, directly generate PDF instead of showing toast
      _generateAndDownloadPDF();
      _createRewardedAd(); // Still create ad for next time
    }
  }

  // void _showRewardedAd() {
  //   dev.log('Attempting to show Rewarded Ad');

  //   if (_rewardedAd != null) {
  //     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdShowedFullScreenContent: (RewardedAd ad) {
  //         dev.log('Rewarded Ad showed full screen content');
  //       },
  //       onAdDismissedFullScreenContent: (RewardedAd ad) {
  //         dev.log('Rewarded Ad was dismissed');
  //         ad.dispose();
  //         _createRewardedAd();
  //       },
  //       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //         dev.log('Rewarded Ad failed to show');
  //         ad.dispose();
  //         _createRewardedAd();
  //         showAnimatedToast('Failed to load reward ad. Please try again.');
  //       },
  //     );

  //     try {
  //       _rewardedAd!.setImmersiveMode(true);
  //       _rewardedAd!.show(
  //         onUserEarnedReward: (_, RewardItem reward) {
  //           _generateAndDownloadPDF();
  //         },
  //       );
  //       _rewardedAd = null;
  //     } catch (e) {
  //       showAnimatedToast('Error showing reward ad: $e');
  //     }
  //   } else {
  //     // showAnimatedToast('Reward ad not ready. Please try again later.');
  //     _generateAndDownloadPDF();
  //     _createRewardedAd();
  //   }
  // }

  void _generateAndDownloadPDF() async {
    if (products.isEmpty) {
      showAnimatedToast('Cannot generate PDF: No products available');
      return;
    }
    try {
      final pdf = pw.Document();

      // Convert screen util dimensions to PDF points
      double pdfFontSize(double size) => size * (72 / 96);

      // Function to create a product cell
      pw.Widget buildProductCell(Product product) {
        pw.Widget productImage;

        // Handle image
        if (product.image != null && product.image!.isNotEmpty) {
          try {
            final file = File(product.image!);
            if (file.existsSync()) {
              productImage = pw.Image(
                pw.MemoryImage(file.readAsBytesSync()),
                height: 120,
                width: 120,
                fit: pw.BoxFit.cover,
              );
            } else {
              productImage = _buildNoImageContainer();
            }
          } catch (e) {
            productImage = _buildNoImageContainer();
          }
        } else {
          productImage = _buildNoImageContainer();
        }

        return pw.Container(
          height: 200,
          width: 160,
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              productImage,
              pw.SizedBox(height: 8),
              pw.Text(
                product.description,
                style: pw.TextStyle(
                  fontSize: pdfFontSize(12),
                  fontWeight: pw.FontWeight.bold,
                ),
                textAlign: pw.TextAlign.center,
                maxLines: 2,
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'Rs. ${product.price.toStringAsFixed(2)}',
                style: pw.TextStyle(
                  fontSize: pdfFontSize(12),
                  color: PdfColors.red,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          header: (pw.Context context) {
            return pw.Container(
              padding: const pw.EdgeInsets.only(bottom: 20),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'Product Catalog',
                    style: pw.TextStyle(
                      fontSize: pdfFontSize(24),
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Total Products: ${products.length}',
                    style: pw.TextStyle(
                      fontSize: pdfFontSize(14),
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.Divider(),
                ],
              ),
            );
          },
          build: (pw.Context context) {
            List<pw.Widget> pages = [];

            // Create rows with 3 products each
            for (var i = 0; i < products.length; i += 3) {
              final rowItems = <pw.Widget>[];

              // Add up to 3 products in this row
              for (var j = 0; j < 3 && (i + j) < products.length; j++) {
                rowItems.add(
                  pw.Expanded(
                    child: buildProductCell(products[i + j]),
                  ),
                );

                // Add spacing between products
                if (j < 2 && (i + j + 1) < products.length) {
                  rowItems.add(pw.SizedBox(width: 10));
                }
              }

              // Add the row to pages
              pages.add(
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: rowItems,
                ),
              );

              // Add spacing between rows
              if (i + 3 < products.length) {
                pages.add(pw.SizedBox(height: 20));
              }
            }

            return pages;
          },
        ),
      );

      // Save PDF to downloads folder
      final directory = Directory("/storage/emulated/0/Download");
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final file = File('${directory.path}/ProductCatalog_$timestamp.pdf');
      final String fileName = 'ProductCatalog_$timestamp.pdf';
      await file.writeAsBytes(await pdf.save());
      final String filePath = '${directory.path}/$fileName';

      if (mounted) {
        setState(() {
          lastDownloadedPdfPath = filePath;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF Downloaded Successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to generate PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  pw.Widget _buildNoImageContainer() {
    return pw.Container(
      height: 120,
      width: 120,
      decoration: pw.BoxDecoration(
        color: PdfColors.grey200,
        border: pw.Border.all(color: PdfColors.grey400),
      ),
      child: pw.Center(
        child: pw.Text(
          'No Image',
          style: pw.TextStyle(
            color: PdfColors.grey600,
          ),
        ),
      ),
    );
  }

  // void _generateAndDownloadPDF() async {
  //   if (products.isEmpty) {
  //     showAnimatedToast('Cannot generate PDF: No products available');
  //     return;
  //   }
  //   try {
  //     final pdf = pw.Document();

  //     // Convert screen util dimensions to PDF points
  //     double pdfFontSize(double size) => size * (72 / 96);

  //     // Define table headers
  //     final headers = ['Sr.No', 'Description', 'Price (Rs.)', 'Image'];

  //     // Create data rows
  //     final tableRows = <List<dynamic>>[];

  //     // Add product data
  //     for (var i = 0; i < products.length; i++) {
  //       final product = products[i];
  //       pw.Widget productImage;

  //       // Handle null or empty imagePath
  //       if (product.image != null && product.image!.isNotEmpty) {
  //         try {
  //           final file = File(product.image!);
  //           if (file.existsSync()) {
  //             productImage = pw.Image(
  //               pw.MemoryImage(file.readAsBytesSync()),
  //               height: 60,
  //               width: 60,
  //               fit: pw.BoxFit.cover,
  //             );
  //           } else {
  //             productImage = _buildNoImageContainer();
  //           }
  //         } catch (e) {
  //           productImage = _buildNoImageContainer();
  //         }
  //       } else {
  //         productImage = _buildNoImageContainer();
  //       }

  //       tableRows.add([
  //         '${i + 1}',
  //         product.description,
  //         'Rs. ${product.price.toStringAsFixed(2)}',
  //         productImage,
  //       ]);
  //     }

  //     pdf.addPage(
  //       pw.MultiPage(
  //         pageFormat: PdfPageFormat.a4,
  //         margin: const pw.EdgeInsets.all(40),
  //         header: (pw.Context context) {
  //           return pw.Container(
  //             padding: const pw.EdgeInsets.only(bottom: 20),
  //             child: pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.center,
  //               children: [
  //                 pw.Text(
  //                   'Image To Image Catalog',
  //                   style: pw.TextStyle(
  //                     fontSize: pdfFontSize(24),
  //                     fontWeight: pw.FontWeight.bold,
  //                   ),
  //                 ),
  //                 pw.SizedBox(height: 10),
  //                 pw.Text(
  //                   'Total Products: ${products.length}',
  //                   style: pw.TextStyle(
  //                     fontSize: pdfFontSize(14),
  //                     color: PdfColors.grey700,
  //                   ),
  //                 ),
  //                 pw.Divider(),
  //               ],
  //             ),
  //           );
  //         },
  //         build: (pw.Context context) {
  //           return [
  //             pw.Table.fromTextArray(
  //               headers: headers,
  //               data: tableRows,
  //               headerStyle: pw.TextStyle(
  //                 fontWeight: pw.FontWeight.bold,
  //                 fontSize: pdfFontSize(14),
  //               ),
  //               cellStyle: pw.TextStyle(
  //                 fontSize: pdfFontSize(12),
  //               ),
  //               headerDecoration: pw.BoxDecoration(
  //                 color: PdfColors.grey300,
  //               ),
  //               cellHeight: 70,
  //               cellAlignments: {
  //                 0: pw.Alignment.center,
  //                 1: pw.Alignment.centerLeft,
  //                 2: pw.Alignment.center,
  //                 3: pw.Alignment.center,
  //               },
  //               columnWidths: {
  //                 0: const pw.FlexColumnWidth(1),
  //                 1: const pw.FlexColumnWidth(4),
  //                 2: const pw.FlexColumnWidth(2),
  //                 3: const pw.FlexColumnWidth(2),
  //               },
  //               headerHeight: 40,
  //               cellPadding: const pw.EdgeInsets.all(5),
  //               oddRowDecoration: pw.BoxDecoration(
  //                 color: PdfColors.grey100,
  //               ),
  //               border: pw.TableBorder.all(
  //                 color: PdfColors.black,
  //                 width: 0.5,
  //               ),
  //             ),
  //           ];
  //         },
  //       ),
  //     );

  //     // Save PDF to downloads folder
  //     final directory = Directory("/storage/emulated/0/Download");
  //     if (!directory.existsSync()) {
  //       directory.createSync(recursive: true);
  //     }

  //     final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  //     final file = File('${directory.path}/ProductCatalog_$timestamp.pdf');
  //     final String fileName = 'ProductCatalog_$timestamp.pdf';
  //     await file.writeAsBytes(await pdf.save());
  //     final String filePath = '${directory.path}/$fileName';
  //     if (mounted) {
  //       setState(() {
  //         lastDownloadedPdfPath = filePath; // Store the complete file path
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('PDF Downloaded Successfully'),
  //           backgroundColor: Colors.green,
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Failed to generate PDF: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }

// Helper method to create a container for missing images
  // pw.Container _buildNoImageContainer() {
  //   return pw.Container(
  //     height: 60,
  //     width: 60,
  //     child: pw.Center(
  //       child: pw.Text('No Image'),
  //     ),
  //   );
  // }

  Future<void> _openPDF() async {
    if (lastDownloadedPdfPath != null) {
      try {
        final file = File(lastDownloadedPdfPath!);
        if (await file.exists()) {
          await OpenFile.open(lastDownloadedPdfPath);
        } else {
          showAnimatedToast("PDF file not found");
        }
      } catch (e) {
        showAnimatedToast("Cannot open PDF: $e");
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red.shade300),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red.shade300),
              ),
              onPressed: () async {
                try {
                  // Clear shared preferences
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  // Clear local database
                  await DatabaseHelper.instance.clearDatabase();

                  if (!mounted) return;

                  // Navigate to Login Screen
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                } catch (e) {
                  showAnimatedToast('Error during logout: $e');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Products Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red.shade300,
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 24.sp),
              onPressed: () async {
                if (userEmail != null) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddProductScreen(),
                    ),
                  );
                  if (result == true) {
                    _loadProducts();
                  }
                }
              },
            ),
            IconButton(
              icon:
                  Icon(Icons.picture_as_pdf, color: Colors.white, size: 24.sp),
              onPressed: () {
                if (products.isEmpty) {
                  showAnimatedToast(
                      'Please add at least one product before generating PDF');
                  return;
                }
                _showRewardedAd();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (_isAdLoaded && _bannerAd != null)
              Container(
                alignment: Alignment.center,
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadProducts,
                child: _buildBody(),
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (lastDownloadedPdfPath != null)
              FloatingActionButton(
                heroTag: 'pdf',
                onPressed: _openPDF,
                backgroundColor: Colors.red.shade300,
                child: const Icon(Icons.visibility, color: Colors.white),
              ),
            SizedBox(width: 10.w),
            FloatingActionButton(
              heroTag: 'logout',
              onPressed: _showLogoutDialog,
              backgroundColor: Colors.red.shade300,
              child: const Icon(Icons.logout, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(
        child: Text('No products added yet'),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4.r)),
                      child: _buildProductImage(product.image),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _deleteProduct(product);
                        },
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red.shade300,
                        ),
                      ),
                      // child: IconButton(
                      //   iconSize: 20.sp,
                      //   padding: EdgeInsets.all(4),
                      //   constraints: BoxConstraints(),
                      //   icon: Icon(
                      //     Icons.delete,
                      //     color: Colors.red.shade300,
                      //   ),
                      //   onPressed: () => _deleteProduct(product),
                      // ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Rs. ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductImage(String? imagePath) {
    if (imagePath == null) {
      return Container(
        color: Colors.grey[200],
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
        ),
      );
    }

    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
      width: double.infinity,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey,
          ),
        );
      },
    );
  }
}
