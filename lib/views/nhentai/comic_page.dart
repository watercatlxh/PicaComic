import 'package:flutter/material.dart';
import 'package:pica_comic/network/nhentai_network/nhentai_main_network.dart';
import 'package:pica_comic/network/res.dart';
import 'package:pica_comic/tools/translations.dart';
import 'package:pica_comic/views/nhentai/comic_tile.dart';
import 'package:pica_comic/views/nhentai/search_page.dart';
import 'package:pica_comic/views/page_template/comic_page.dart';
import '../../base.dart';
import '../main_page.dart';
import 'comments.dart';

class NhentaiComicPage extends ComicPage<NhentaiComic>{
  const NhentaiComicPage(this.id, {super.key});

  final String id;

  @override
  Row? get actions => Row(
    children: [
      Expanded(
        child: ActionChip(
          label: Text("${data!.tags["Pages"]?.elementAtOrNull(0) ?? ""}P"),
          avatar: const Icon(Icons.pages),
          onPressed: () {},
        ),
      ),
      Expanded(
        child: ActionChip(
          label: Text("收藏".tl),
          avatar: const Icon(Icons.bookmark_add_outlined),
          onPressed: (){}/* favoriteComic(FavoriteComicWidget(
            havePlatformFavorite: appdata.jmEmail != "",
            needLoadFolderData: true,
            foldersLoader: () async{
              var res = await jmNetwork.getFolders();
              if(res.error){
                return res;
              }else{
                var resData = <String, String>{"-1":"全部收藏".tl};
                resData.addAll(res.data);
                return Res(resData);
              }
            },
            favoriteOnPlatform: data!.favorite,
            selectFolderCallback: (folder, page) async{
              if(page == 0){
                showMessage(context, "正在添加收藏".tl);
                var res = await jmNetwork.favorite(id);
                if(res.error){
                  showMessage(Get.context, res.errorMessageWithoutNull);
                  return;
                }
                if(folder != "-1") {
                  var res2 = await jmNetwork.moveToFolder(id, folder);
                  if (res2.error) {
                    showMessage(Get.context, res2.errorMessageWithoutNull);
                    return;
                  }
                }
                data!.favorite = true;
                showMessage(Get.context, "成功添加收藏".tl);
              }else{
                LocalFavoritesManager().addComic(folder, FavoriteItem.fromJmComic(JmComicBrief(
                    id,
                    data!.author.elementAtOrNull(0)??"",
                    data!.name,
                    data!.description,
                    [],
                    [],
                    ignoreExamination: true
                )));
                showMessage(Get.context, "成功添加收藏".tl);
              }
            },
            cancelPlatformFavorite: ()async{
              showMessage(context, "正在取消收藏".tl);
              var res = await jmNetwork.favorite(id);
              showMessage(Get.context, !res.error?"成功取消收藏".tl:"网络错误".tl);
              data!.favorite = false;
            },
          )),*/
        ),
      ),
      Expanded(
        child: ActionChip(
            label: Text("评论".tl),
            avatar: const Icon(Icons.comment_outlined),
            onPressed: () => showComments(context, id)),
      ),
    ],
  );

  @override
  String get cover => data!.cover;

  @override
  FilledButton get downloadButton => FilledButton(
    child: Text("下载".tl),
    onPressed: (){
      //TODO
    },
  );

  @override
  EpsData? get eps => null;

  @override
  String? get introduction => null;

  @override
  Future<Res<NhentaiComic>> loadData() => NhentaiNetwork().getComicInfo(id);

  @override
  int? get pages => null;

  @override
  FilledButton get readButton => FilledButton(
    child: Text("阅读".tl),
    onPressed: (){
      //TODO
    },
  );

  @override
  SliverGrid? recommendationBuilder(NhentaiComic data) => SliverGrid(
    delegate: SliverChildBuilderDelegate(
        childCount: data.recommendations.length, (context, i) {
      return NhentaiComicTile(data.recommendations[i]);
    }),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: comicTileMaxWidth,
      childAspectRatio: comicTileAspectRatio,
    ),
  );

  @override
  String get tag => "Nhentai $id";

  @override
  Map<String, List<String>>? get tags => data!.tags;

  @override
  void tapOnTags(String tag) {
    MainPage.to(()=>NhentaiSearchPage(tag));
  }

  @override
  ThumbnailsData? get thumbnailsCreator => ThumbnailsData(data!.thumbnails, (page)async => const Res([]), 1);

  @override
  String? get title => data!.title;

  @override
  Card? get uploaderInfo => null;

}