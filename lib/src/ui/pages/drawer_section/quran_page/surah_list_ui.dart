import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/model/surah_wise.dart';
import 'package:provider/provider.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/ui/pages/drawer_section/quran_page/audio_config.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
class SurahListUi extends StatefulWidget {
  final List<SurahWise> arabicList;
  final List<SurahWise> urduList;
  final int surahNumber;
  final AudioPlayer player;
  final AnimationController animationController;

  const SurahListUi(this.animationController, this.arabicList, this.urduList,
      this.surahNumber, this.player,
      {Key? key})
      : super(key: key);

  @override
  State<SurahListUi> createState() => _SurahListUiState();
}

class _SurahListUiState extends State<SurahListUi> {
  late final AudioConfiguration audioConfiguration;
  int currentIndex = 0;
  late AutoScrollController controller;
  @override
  void initState() {
    controller = AutoScrollController(axis: Axis.vertical);
    audioConfiguration = AudioConfiguration(widget.player);
    playAudio();
    widget.player.playerStateStream.listen((snapshot) async {
      final playerState = snapshot;
      final processingState = playerState.processingState;
      final playing = playerState.playing;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        print(playing);
      } else if (processingState == ProcessingState.completed) {
        currentIndex++;
        setState(() {

        });
        print(currentIndex);
        _scrollToIndex();
        await playAudio();
      }
    });
    super.initState();
  }


  playAudio() async {
    int updatedCurrentIndex = currentIndex + 1;

    String ayat = (updatedCurrentIndex < 10)
        ? "00$updatedCurrentIndex"
        : (updatedCurrentIndex < 100)
        ? "0$updatedCurrentIndex"
        : updatedCurrentIndex.toString();
    String surah = (widget.surahNumber < 10)
        ? "00${widget.surahNumber}"
        : (widget.surahNumber < 100)
        ? "0${widget.surahNumber}"
        : "${widget.surahNumber}";

    print('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await audioConfiguration
        .init('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await widget.player.play();
  }
  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );

  //int counter = -1;
  Future _scrollToIndex() async {
    print(currentIndex);
    await controller.scrollToIndex(currentIndex, preferPosition: AutoScrollPosition.begin);
  }
  @override
  void dispose() {
    super.dispose();
  }
  final sizedBox = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.arabicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  currentIndex = index;
                });
                playAudio();
                widget.animationController.forward();
                _scrollToIndex();
              },
              child: _wrapScrollTag(
                index: index,
                child: Container(

                  margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().selectedTheme
                        ? AppColors.itemBackgroundScreenColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[400]!, width: 0.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0.75),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      sizedBox,
                      Text(
                        widget.arabicList[index].ar,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: AppConfig.of(context).appWidth(12.0),
                            color: currentIndex == index
                                ? context.watch<ThemeProvider>().selectedTheme
                                ? AppColors.greenColor
                                : Colors.pink
                                : context.watch<ThemeProvider>().selectedTheme
                                ? Colors.white
                                : Colors.grey[600]!),
                        textAlign: TextAlign.center,
                      ),
                      sizedBox,
                      Text(widget.urduList[index].ur,
                          style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: context.watch<ThemeProvider>().selectedTheme
                                  ? Colors.white
                                  : Colors.grey[600]!,
                              fontSize: AppConfig.of(context).appWidth(4.0)),
                          textAlign: TextAlign.center),
                      sizedBox,
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              'Surah:${widget.arabicList[index].surah}-Ayat:${widget.arabicList[index].ayat}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                  color: context
                                      .watch<ThemeProvider>()
                                      .selectedTheme
                                      ? Colors.white
                                      : Colors.grey[600]!,
                                  fontSize:
                                  AppConfig.of(context).appWidth(3.50)),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      sizedBox,
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}







