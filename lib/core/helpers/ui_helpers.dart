import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// class Helpers {
//   static void showCommonSnackBar(
//       BuildContext context, String message, SnackBarStatus snackBarStatus,
//       {bool showDescription = false, String? descriptionMessage = ""}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         elevation: 0.0,
//         behavior: SnackBarBehavior.floating,
//         dismissDirection: DismissDirection.endToStart,
//         backgroundColor: chooseSnackBarColor(snackBarStatus),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//         ),
//         content: Row(
//           children: [
//             snackBarStatus == SnackBarStatus.error
//                 ? const CommonAssetSVGImage(imageName: ImagesPath.errorState)
//                 : snackBarStatus == SnackBarStatus.waring
//                     ? const CommonAssetSVGImage(imageName: ImagesPath.errorIcon)
//                     : const CommonAssetSVGImage(
//                         imageName: ImagesPath.successSnackIcon),

//             const SizedBox(width: 10), // Add spacing between icon and text
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CommonTextWidget(
//                     fontSize: AppFontSize.s14.sp,
//                     fontWeight: AppFontWeights.fw500,
//                     text: message,
//                     textColor: AppColors.generalWhite,
//                     maxLines: 2,
//                     softWrap: true,
//                     textOverflow: TextOverflow.ellipsis,
//                   ),
//                   showDescription
//                       ? CommonTextWidget(
//                           maxLines: 2,
//                           softWrap: true,
//                           textOverflow: TextOverflow.ellipsis,
//                           fontSize: AppFontSize.s14.sp,
//                           text: descriptionMessage!,
//                           textColor: AppColors.generalWhite,
//                           fontWeight: AppFontWeights.fw400,
//                         )
//                       : const SizedBox(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         duration: const Duration(
//           seconds: 2,
//         ),
//       ),
//     );
//   }

//   static Color chooseSnackBarColor(SnackBarStatus status) {
//     Color color;
//     switch (status) {
//       case SnackBarStatus.success:
//         color = AppColors.successDefault;
//         break;
//       case SnackBarStatus.waring:
//         color = AppColors.warningDefault;
//         break;
//       case SnackBarStatus.error:
//         color = AppColors.errorDefault;
//     }
//     return color;
//   }

//   /// Loader Widget
//   static void showLoaderWidget(BuildContext context) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return PopScope(
//           canPop: true,
//           child: AlertDialog(
//             contentPadding: const EdgeInsets.all(AppPadding.p80),
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             insetPadding: EdgeInsets.zero,
//             content: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Lottie.asset(
//                 ImagesPath.loaderImage,
//                 width: 90,
//                 height: 90,
//                 animate: true,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Convert Files To 64
//   static String convertFilesToBase64({required String filePath}) {
//     final bytes = File(filePath).readAsBytesSync();
//     String file64 = base64.encode(bytes);
//     return file64;
//   }

//   /// Check Permission
//   static checkNotificationPermission() async {
//     await Permission.notification.isDenied.then((value) {
//       if (value) {
//         Permission.notification.request();
//       }
//     });
//   }

//   /// Check User Auth Function
//   static checkUserAuth({
//     required BuildContext context,
//     required CustomError error,
//   }) {
//     if (error.statusCode == 401) {
//       SharedPreference.clearLocalStorage();
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         RouteKeys.login,
//         (route) => false,
//       );
//     } else {
//       Helpers.showCommonSnackBar(
//         context,
//         error.errorMessage,
//         SnackBarStatus.error,
//       );
//     }
//   }

//   /// Show Error In Get Case
//   static showErrorInGetCaseOrConnection({
//     required BuildContext context,
//     required CustomError error,
//     required VoidCallback onTap,
//   }) {
//     if (error.statusCode == 401) {
//       SharedPreference.clearLocalStorage();
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         RouteKeys.login,
//         (route) => false,
//       );
//     } else {
//       return CommonServerErrorWidget(
//         errorMessage: error.errorMessage,
//         onTap: onTap,
//       );
//     }
//   }

//   /// Open Email
//   static Future<void> launchMail(String url) async {
//     if (!await launchUrl(Uri.parse(url),
//         mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   /// Copy Text When Click
//   static copyTextWhenCLick({required String text}) {
//     Clipboard.setData(ClipboardData(
//       text: text,
//     ));
//   }

//   /// Hide Keyboard After Finish Typing
//   static hideKeyboard(context) {
//     FocusScope.of(context).requestFocus(FocusNode());
//   }

//   static void showLogoutDialog(
//     BuildContext context, {
//     VoidCallback? onCancelTap,
//     String cancelText = "Cancel",
//     required String title,
//     required String descriptionMessage,
//     required String confirmText,
//     required VoidCallback onConfirmTap,
//   }) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           title: Center(
//             child: CommonTextWidget(
//               text: title,
//               fontSize: AppFontSize.s16.sp,
//               textColor: AppColors.black,
//               fontWeight: AppFontWeights.fw500,
//             ),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 descriptionMessage,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: AppFontSize.s14.sp,
//                   color: AppColors.grey500,
//                   fontWeight: AppFontWeights.fw400,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               CommonButton(
//                   buttonWidth: 130.w,
//                   buttonHeight: 39.h,
//                   buttonColor: AppColors.red,
//                   borderRadius: 15.r,
//                   text: confirmText,
//                   textFontSize: AppFontSize.s12.sp,
//                   onTap: onConfirmTap,
//                   isEnable: true),
//               SizedBox(height: 10.h),
//               TextButton(
//                 onPressed: onCancelTap ?? () => Navigator.pop(context),
//                 child: CommonTextWidget(
//                   fontSize: AppFontSize.s14.sp,
//                   textColor: AppColors.red,
//                   text: cancelText,
//                   fontWeight: AppFontWeights.fw500,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
