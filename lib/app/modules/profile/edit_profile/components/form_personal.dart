import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:triwarna_rebuild/app/components/base_formgroupdropdown.dart';
import 'package:triwarna_rebuild/app/components/base_formgroupfield.dart';
import 'package:triwarna_rebuild/app/components/base_text.dart';
import 'package:triwarna_rebuild/app/components/base_textarea.dart';
import 'package:triwarna_rebuild/app/core/values/app_helpers.dart';
import 'package:triwarna_rebuild/app/core/values/colors.dart';
import 'package:triwarna_rebuild/app/modules/dashboard/controller.dart';
import 'package:triwarna_rebuild/app/modules/profile/controller.dart';
import 'package:triwarna_rebuild/app/modules/profile/edit_profile/components/item_field.dart';

class FormViewPersonal extends StatelessWidget {
  FormViewPersonal({super.key});
  final controller = Get.find<ProfileController>();
  final userController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Container(
          width: Get.width,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemField(
                  label: 'Nama Lengkap',
                  value: controller.namaController.value.text,
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Tempat Lahir',
                  value: controller.tempatLahirController.value.text == ''
                      ? '-'
                      : controller.tempatLahirController.value.text,
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Tanggal Lahir',
                  value: controller.tglLahirController.value.text == ''
                      ? '-'
                      : controller.tglLahirController.value.text,
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Jenis Kelamin',
                  value: controller.selectJk.value ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Kelurahan',
                  value: userController.profile.value?.village ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Alamat',
                  value: controller.alamatController.value.text == ''
                      ? '-'
                      : controller.alamatController.value.text,
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Agama',
                  value: controller.selectAgama.value ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Jenis Identitas',
                  value: controller.selectIdentitas.value ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'No. Identitas',
                  value: controller.noIndentitasController.value.text == ''
                      ? '-'
                      : controller.noIndentitasController.value.text,
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Pendidikan Terakhir',
                  value: controller.selectPendidikan.value ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Jenis Pekerjaan',
                  value: userController.profile.value?.job ?? '-',
                ),
                const SizedBox(height: 15),
                ItemField(
                  label: 'Status Menikah',
                  value: controller.selectStatus.value ?? '-',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormEditPersonal extends StatelessWidget {
  FormEditPersonal({super.key});
  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(
            () => Column(
              children: [
                BaseFormGroupField(
                  label: 'Nama Lengkap',
                  hint: 'Masukkan nama lengkap anda',
                  controller: controller.namaController.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama lengkap tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupField(
                  label: 'Tempat Lahir',
                  hint: 'Masukkan tempat lahir anda',
                  controller: controller.tempatLahirController.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tempat lahir tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupField(
                  label: 'Tanggal Lahir',
                  hint: 'Masukkan tanggal lahir anda',
                  controller: controller.tglLahirController.value,
                  readOnly: true,
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      locale: LocaleType.id,
                      currentTime:
                          controller.selectTglLahir.value ?? DateTime.now(),
                      onChanged: (time) {
                        final selectTime = AppHelpers.dateFormat(time);
                        controller.selectTglLahir.value = time;
                        controller.tglLahirController.value.text = selectTime;
                      },
                    );
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tanggal lahir tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupDropdown(
                  label: 'Jenis Kelamin',
                  hint: 'Pilih jenis kelamin anda',
                  value: controller.selectJk.value,
                  items: controller.jenisKelamin
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: BaseText(text: e),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectJk.value = value.toString(),
                  validator: (value) {
                    if (controller.selectJk.value == null) {
                      return 'Jenis kelamin tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseTextArea(
                  label: 'Alamat',
                  hint: 'Masukkan alamat rumah anda',
                  controller: controller.alamatController.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BaseText(
                    text: 'Kelurahan/Desa',
                    bold: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TypeAheadFormField(
                  hideSuggestionsOnKeyboardHide: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: controller.kelurahanController.value,
                    decoration: InputDecoration(
                      hintText: 'Kelurahan/Desa',
                      helperText:
                          '*Silahkan ketik nama kelurahan/desa atau nama kecamatan untuk mencari',
                      helperMaxLines: 2,
                      helperStyle: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kelurahan/Desa tidak boleh kosong';
                    }

                    return null;
                  },
                  onSuggestionSelected: (suggestion) {
                    controller.selectKelurahan.value =
                        suggestion.kdKelurahan ?? '';
                    controller.kelurahanController.value.text =
                        suggestion.namaKelurahan.toString().capitalize ?? '';
                  },
                  suggestionsCallback: (pattern) => controller.kelurahan
                      .where((e) =>
                          e.namaKelurahan
                              .toString()
                              .toLowerCase()
                              .contains(pattern) ||
                          e.namaKecamatan
                              .toString()
                              .toLowerCase()
                              .contains(pattern))
                      .toList(),
                  itemBuilder: (context, suggest) {
                    return ListTile(
                      title: BaseText(
                          text: suggest.namaKelurahan.toString().capitalize ??
                              ''),
                      subtitle: BaseText(
                          text: suggest.namaKecamatan.toString().capitalize ??
                              ''),
                    );
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupDropdown(
                  label: 'Agama',
                  hint: 'Pilih agama anda',
                  value: controller.selectAgama.value,
                  items: controller.agama
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: BaseText(text: e),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectAgama.value = value.toString(),
                  validator: (value) {
                    if (controller.selectAgama.value == null) {
                      return 'Agama tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupDropdown(
                  label: 'Jenis Identitas',
                  hint: 'Pilih jenis identitas anda',
                  value: controller.selectIdentitas.value,
                  items: controller.identitas
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: BaseText(text: e),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectIdentitas.value = value.toString(),
                  validator: (value) {
                    if (controller.selectIdentitas.value == null) {
                      return 'Jenis identitas tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupField(
                  label: 'No, Identitas',
                  hint: 'Masukkan no. identitan anda',
                  controller: controller.noIndentitasController.value,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'No. identitas tidak boleh kosong';
                    } else {
                      if (controller.selectIdentitas.value == 'KTP' &&
                              value.length < 16 ||
                          controller.selectIdentitas.value == 'SIM' &&
                              value.length < 10) {
                        return 'No. identitas tidak valid';
                      }
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupDropdown(
                  label: 'Pendidikan Terakhir',
                  hint: 'Pilih pendidikan terakhir anda',
                  value: controller.selectPendidikan.value,
                  items: controller.pendidikan
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: BaseText(text: e),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectPendidikan.value = value.toString(),
                  validator: (value) {
                    if (controller.selectPendidikan.value == null) {
                      return 'Pendidikan terakhir tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BaseFormGroupDropdown(
                  label: 'Jenis Pekerjaan',
                  hint: 'Pilih jenis pekerjaan anda',
                  value: controller.selectPekerjaan.value,
                  items: controller.pekerjaan
                      .map((e) => DropdownMenuItem<String>(
                            value: e.id,
                            child: BaseText(text: e.nama),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      controller.selectPekerjaan.value = value.toString(),
                  validator: (value) {
                    if (controller.selectPekerjaan.value == null) {
                      return 'Jenis pekerjaan tidak boleh kosong';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: BaseText(
                    text: 'Status Pernikahan',
                    bold: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                RadioGroup.builder(
                  direction: Axis.horizontal,
                  groupValue: controller.selectStatus.value,
                  textStyle: const TextStyle(fontSize: 16),
                  activeColor: purpleColor,
                  horizontalAlignment: MainAxisAlignment.spaceBetween,
                  onChanged: (value) {
                    controller.selectStatus.value = value;
                  },
                  items: controller.status,
                  itemBuilder: (value) {
                    return RadioButtonBuilder(
                      value.toString(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
