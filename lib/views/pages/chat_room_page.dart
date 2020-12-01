import 'package:aunty_rafiki/models/send_menu_items.dart';
import 'package:aunty_rafiki/sample/model/chat.dart';
import 'package:aunty_rafiki/views/backgrounds/background.dart';
import 'package:aunty_rafiki/sample/widgets/message_edit_bar.dart';
import 'package:aunty_rafiki/sample/widgets/message_list.dart';
import 'package:aunty_rafiki/views/components/app/chat_detail_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

class ChatRoomPage extends StatelessWidget {
  ChatRoomPage();

  @override
  Widget build(BuildContext context) {
    Chat chat = ModalRoute.of(context).settings.arguments;

    Future<void> loadAssets() async {
      List<Asset> resultList = List<Asset>();
      List<Asset> images = List<Asset>();
      String error = 'No Error Dectected';

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 10,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: true,
            selectCircleStrokeColor: "#000000",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }
      print(resultList);
      print(error);
    }

    void showModal() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Container(
                        height: 4,
                        width: 50,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      itemCount: menuItems.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: ListTile(
                            onTap: () {
                              if (menuItems[index].text == "Photos & Videos")
                                loadAssets();
                            },
                            leading: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: menuItems[index].color.shade50,
                              ),
                              height: 50,
                              width: 50,
                              child: Icon(
                                menuItems[index].icons,
                                size: 20,
                                color: menuItems[index].color.shade400,
                              ),
                            ),
                            title: Text(menuItems[index].text),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Provider<Chat>.value(
      value: chat,
      child: Scaffold(
        appBar: ChatDetailPageAppBar(),
        body: Stack(
          children: <Widget>[
            ChatBackground(),
            Column(
              children: <Widget>[
                MessageList(),
                MessageEditBar(
                  onPressed: () {
                    showModal();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

