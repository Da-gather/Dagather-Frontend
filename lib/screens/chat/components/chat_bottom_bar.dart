import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dagather_frontend/models/correct_spell_model.dart';
import 'package:dagather_frontend/models/message_model.dart';
import 'package:dagather_frontend/services/chat_service.dart';
import 'package:dagather_frontend/services/translate_service.dart';
import 'package:dagather_frontend/utilities/colors.dart';
import 'package:dagather_frontend/utilities/fonts.dart';
import 'package:dagather_frontend/utilities/styles.dart';
import 'package:dagather_frontend/utilities/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

class ChatBottomBar extends StatefulWidget {
  final String docId;

  const ChatBottomBar({super.key, required this.docId});

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  File? imageFile;
  final TextEditingController _textController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  bool isImageSending = false;
  bool isTextSending = false;
  String srcLangType = '';
  String tarLangType = 'ko';

  bool translateButtonIsTapped = false;

  late List<Map<String, String>> avaliableDetectLanguages;

  @override
  void initState() {
    super.initState();
    _setAvaliableLanguages();
  }

  void _setAvaliableLanguages() {
    if (srcLangType != '') {
      avaliableDetectLanguages = detectLanguages
          .where((element) =>
              avaliableTranslate[srcLangType]!.contains(element['code']))
          .toList();
    } else {
      avaliableDetectLanguages = detectLanguages;
    }
    tarLangType = avaliableDetectLanguages[0]['code']!;
  }

  void _removeImage() {
    imageFile = null;
    setState(() {});
  }

  void _getImage() async {
    await picker.pickImage(source: ImageSource.gallery).then((file) {
      developer.log(file.toString());
      if (file != null) {
        imageFile = File(file.path);
        setState(() {});
      }
    });
  }

  Future<String> _uploadImage() async {
    isImageSending = true;
    setState(() {});

    String fileName = const Uuid().v4();
    var ref =
        FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');
    var uploadTask = await ref.putFile(imageFile!);

    return await uploadTask.ref.getDownloadURL();
  }

  void _sendImageMessage() async {
    final MessageModel data = MessageModel(
        content: await _uploadImage(),
        corrected: null,
        sender: FirebaseAuth.instance.currentUser!.uid,
        type: MessageType.image.name,
        read: false,
        created: Timestamp.now());

    await addMessage(data);

    _removeImage();
    isImageSending = false;
    setState(() {});
  }

  void _sendTextMessage() async {
    isTextSending = true;
    setState(() {});

    final CorrectSpellModel correctSpellModel =
        await ChatService.checSpellingOfkMessage(_textController.text);

    final MessageModel data = MessageModel(
        content: _textController.text,
        corrected: correctSpellModel,
        sender: FirebaseAuth.instance.currentUser!.uid,
        type: MessageType.text.name,
        read: false,
        created: Timestamp.now());

    await addMessage(data);

    _textController.clear();
    srcLangType = '';
    isTextSending = false;
    setState(() {});
  }

  Future<void> addMessage(MessageModel data) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.docId)
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshots, _) =>
              MessageModel.fromJson(snapshots.data()!),
          toFirestore: (message, _) => message.toJson(),
        )
        .add(data)
        .then(
      (value) {
        final lastMsg =
            data.type == MessageType.image.name ? "이미지" : data.content;
        _updateChatData({
          "last_msg": lastMsg,
          "last_sender": data.sender,
          "last_time": data.created,
        });
      },
    ).then((value) {
      _increaseNotReadMsgCount();
    });
  }

  void _increaseNotReadMsgCount() async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.docId)
        .update({"msg_not_read": FieldValue.increment(1)});
  }

  void _updateChatData(object) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.docId)
        .update(object);
  }

  Widget _getImageSelectWidget() {
    if (isImageSending) {
      return Container(
        color: AppColor.g200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)).r,
                child: Container(
                  width: 112.w,
                  height: 112.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.1), BlendMode.dstATop),
                      image: Image.file(File(imageFile!.path)).image,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    "업로드 중",
                    style: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 13.sp,
                      fontVariations: const [
                        FontVariation('wght', 600),
                      ],
                      color: AppColor.g800,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: AppColor.g200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)).r,
                child: Container(
                  width: 112.w,
                  height: 112.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      image: Image.file(File(imageFile!.path)).image,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              SizedBox(
                width: 24.w,
                height: 24.w,
                child: IconButton(
                  onPressed: _removeImage,
                  padding: const EdgeInsets.all(0),
                  color: AppColor.g400,
                  iconSize: 24.w,
                  icon: const Icon(
                    Icons.cancel_rounded,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _getTranslateWidget() {
    return Container(
      color: AppColor.g200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: _textController.text.isEmpty
                        ? null
                        : () async {
                            srcLangType =
                                await TranslateService.getLanguageCodePapago(
                                    _textController.text);
                            _setAvaliableLanguages();
                            setState(() {});
                          },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 12.w),
                      backgroundColor: AppColor.g100,
                      disabledBackgroundColor: AppColor.g300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                    ),
                    child: Text(
                        _textController.text.isEmpty ? "언어 감지필요" : "언어 감지하기",
                        style: TextStyle(
                          fontFamily: pretendardFont,
                          fontSize: 15.sp,
                          fontVariations: const [
                            FontVariation('wght', 600),
                          ],
                          color: _textController.text.isEmpty
                              ? AppColor.g200
                              : AppColor.g600,
                        ))),
                SizedBox(
                  width: 6.w,
                ),
                Icon(
                  Icons.east_rounded,
                  color: AppColor.g600,
                  size: 20.w,
                ),
                SizedBox(
                  width: 6.w,
                ),
                avaliableDetectLanguages.isEmpty
                    ? const Text("d")
                    : DropdownButtonHideUnderline(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.g100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 8.w),
                            child: DropdownButton(
                              hint: Text(
                                "번역 언어",
                                style: FontStyle.hintTextStyle,
                              ),
                              enableFeedback: true,
                              value: tarLangType,
                              elevation: 0,
                              style: FontStyle.inputTextStyle,
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: AppColor.g400,
                                size: 24.w,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              items: avaliableDetectLanguages.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item["code"],
                                  child: Text(item["language"]!),
                                );
                              }).toList(),
                              onChanged: (dynamic value) {
                                tarLangType = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            TextButton(
                onPressed: srcLangType == '' || _textController.text.isEmpty
                    ? null
                    : () async {
                        final String translatedText =
                            await TranslateService.getTranslationPapago(
                                text: _textController.text,
                                source: srcLangType,
                                target: tarLangType);
                        _textController.text = translatedText;
                        srcLangType = '';
                        setState(() {});
                      },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                  backgroundColor: AppColor.yellow4,
                  disabledBackgroundColor: AppColor.g300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                ),
                child: Text(
                  "번역",
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 15.sp,
                    fontVariations: const [
                      FontVariation('wght', 600),
                    ],
                    color: srcLangType == '' || _textController.text.isEmpty
                        ? AppColor.g200
                        : AppColor.g900,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageFile != null) _getImageSelectWidget(),
        if (translateButtonIsTapped) _getTranslateWidget(),
        Container(
          height: 60.h,
          decoration: const BoxDecoration(
            color: AppColor.g200,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => _getImage(),
                color: AppColor.g500,
                icon: const Icon(Icons.add_a_photo_rounded),
              ),
              Flexible(
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: _textController,
                  style: TextStyle(
                    fontFamily: pretendardFont,
                    fontSize: 14.sp,
                    fontVariations: const [
                      FontVariation('wght', 500),
                    ],
                    color: AppColor.g900,
                  ),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '메세지 보내기',
                    hintStyle: TextStyle(
                      fontFamily: pretendardFont,
                      fontSize: 14.sp,
                      fontVariations: const [
                        FontVariation('wght', 400),
                      ],
                      color: AppColor.g500,
                    ),
                    contentPadding: const EdgeInsets.all(18).w,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  translateButtonIsTapped = !translateButtonIsTapped;
                  setState(() {});
                },
                color: AppColor.blue,
                icon: const Icon(Icons.translate_rounded),
              ),
              IconButton(
                disabledColor: AppColor.g300,
                onPressed: isImageSending ||
                        isTextSending ||
                        (_textController.text.isEmpty && imageFile == null)
                    ? null
                    : () {
                        /// 텍스트 X, 이미지 X: 버튼 비활성화
                        /// 텍스트 O, 이미지 X: 텍스트 전송
                        /// 텍스트 X, 이미지 O: 이미지 전송
                        /// 텍스트 O, 이미지 O: 텍스트 전송 후 이미지 전송

                        if (_textController.text.isNotEmpty &&
                            imageFile == null) {
                          _sendTextMessage();
                        }
                        if (_textController.text.isEmpty && imageFile != null) {
                          _sendImageMessage();
                        }
                        if (_textController.text.isNotEmpty &&
                            imageFile != null) {
                          _sendTextMessage();
                          _sendImageMessage();
                        }
                      },
                color: AppColor.blue,
                icon: const Icon(Icons.send_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
