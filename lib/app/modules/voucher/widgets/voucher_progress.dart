import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triwarna_rebuild/app/components/base_nodata.dart';
import 'package:triwarna_rebuild/app/components/base_text.dart';
import 'package:triwarna_rebuild/app/core/values/colors.dart';
import 'package:triwarna_rebuild/app/modules/voucher/components/card_voucher.dart';
import 'package:triwarna_rebuild/app/modules/voucher/controller.dart';

class VoucherProgress extends StatelessWidget {
  VoucherProgress({super.key});
  final controller = Get.find<VoucherController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BaseText(
                    text: 'Scan Barcode untuk mendapatkan Hadiah',
                    size: 16,
                    bold: FontWeight.w600,
                  ),
                  BaseText(
                    text: 'Lihat data voucher penukaran poin anda disini!',
                    size: 12,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: controller.isLoading.value
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(15),
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return const CardVoucherLoading();
                    },
                  )
                : controller.voucherProgress.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: BaseNoData(
                          image: 'empty_voucher.svg',
                          title: 'Voucher Tidak Ada',
                          subtitle:
                              'Untuk mendapatkan voucher, tukar point dengan hadiah yang tersedia.',
                          labelButton: 'Refresh Voucher',
                          onPressed: () {
                            controller.isLoading.value = true;
                            controller.fetchVoucher();
                          },
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: controller.refreshVoucher,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(15),
                          itemCount: controller.voucherProgress.length,
                          itemBuilder: (context, index) {
                            final voucher = controller.voucherProgress[index];

                            return CardVoucher(
                              qrImage: voucher.qrcode ?? '',
                              namaBarang: voucher.hadiah?.deskripsiBarang ?? '',
                              image: voucher.hadiah?.gambar ?? '',
                              serialNumber: voucher.code ?? '',
                              status: voucher.statusHadiah?.status ?? '',
                              bgColor: softPurpleColor,
                              medalImage: controller.loyaltyLevel.value
                                          ?.toLowerCase() ==
                                      'silver'
                                  ? 'silver_medal.svg'
                                  : controller.loyaltyLevel.value
                                              ?.toLowerCase() ==
                                          'gold'
                                      ? 'gold_medal.svg'
                                      : 'platinum_medal.svg',
                              onTap: () {
                                Get.toNamed(
                                  '/tracking',
                                  arguments: voucher.serialNumber,
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
