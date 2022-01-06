import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ufone_web/src/bloc/utility/app_config.dart';
import 'package:ufone_web/src/cubit/surah_name/surah_name_cubit.dart';
import 'package:ufone_web/src/cubit/surah_wise/surah_wise_cubit.dart';
import 'package:ufone_web/src/provider/theme_provider.dart';
import 'package:ufone_web/src/resource/repository/surah_name_repository.dart';
import 'package:ufone_web/src/resource/repository/surah_wise_repository.dart';
import 'package:ufone_web/src/ui/pages/drawer_section/quran_page/surah_list_ui.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/app_colors.dart';
import 'package:ufone_web/src/ui/ui_constants/theme/string.dart';
import 'package:ufone_web/src/ui/widgets/web_app_bar.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class AlQuranPage extends StatefulWidget {
  const AlQuranPage({Key? key}) : super(key: key);

  @override
  _AlQuranPageState createState() => _AlQuranPageState();
}

class _AlQuranPageState extends State<AlQuranPage>
    with SingleTickerProviderStateMixin {
  String? dropdownValue;
  final surahCubit = SurahNameCubit(SurahNameRepository.getInstance()!);
  final surahWiseCubit = SurahWiseCubit(SurahWiseRepository.getInstance()!);
  final AudioPlayer player = AudioPlayer();
  int surahNumber = 1;
  late final AnimationController animationController;

  @override
  void initState() {
    dropdownValue = "Al-Fatiha";
    surahCubit.getSurahList();
    surahWiseCubit.getSurahByIdAndLang(1).then((value) {
      animationController.forward();
    });

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    surahCubit.close();
    surahWiseCubit.close();
    player.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WebAppBar(appBarMessage: AppString.al_quran),
      ),
      body: Column(
        children: [
          BlocBuilder<SurahNameCubit, SurahNameState>(
              bloc: surahCubit,
              builder: (context, state) {
                if (state is SurahNameInitial) {
                  return SizedBox.shrink();
                } else if (state is SurahNameLoadingState) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircularProgressIndicator(
                          color: AppColors.greenColor),
                    ),
                  );
                } else if (state is SurahNameSuccessState) {
                  return PhysicalModel(
                    color: Colors.white,
                    elevation: 4.0,
                    shadowColor: Colors.grey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.watch<ThemeProvider>().selectedTheme
                            ? AppColors.itemBackgroundScreenColor
                            : Colors.white,
                      ),
                      height: 80,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_downward),
                                iconSize: 22,
                                elevation: 16,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: state.SurahNameList.map<
                                    DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    onTap: () async {
                                      if (state.SurahNameList.contains(value)) {
                                        animationController.reverse();
                                        player.stop();
                                        await surahWiseCubit
                                            .getSurahByIdAndLang(
                                                int.parse(value.number));
                                        surahNumber = int.parse(value.number);
                                        animationController.forward();
                                      }
                                    },
                                    value: value.name,
                                    child: Text(value.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 12,
                                            )),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                          _PlayPause(
                              animationController: animationController,
                              onPressed: () {
                                if (player.playing) {
                                  animationController.reverse();
                                  player.pause();
                                } else {
                                  animationController.forward();
                                  player.play();
                                }
                              }),
                          const Spacer(),
                          const Spacer(flex: 3),
                        ],
                      ),
                    ),
                  );
                } else if (state is SurahNameErrorState) {
                  return Text(state.message);
                } else {
                  return Text('Something Went Wrong');
                }
              }),
          BlocBuilder<SurahWiseCubit, SurahWiseState>(
            bloc: surahWiseCubit,
            builder: (context, state) {
              if (state is SurahWiseInitial) {
                return SizedBox.shrink();
              } else if (state is SurahWiseLoadingState) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppConfig.of(context).appWidth(30)),
                  child: CircularProgressIndicator(color: AppColors.greenColor),
                );
              } else if (state is SurahWiseSuccessState) {
                // return Expanded(child: MyHomePage(title: 'dadada',));
                return SurahListUi(animationController, state.arbiSurah,
                    state.urduSurah, surahNumber, player);
              } else if (state is SurahWiseErrorState) {
                return Center(
                    child: Text(
                  state.message,
                  style: Theme.of(context).textTheme.bodyText1,
                ));
              } else {
                return Center(
                    child: Text(
                  'Some Thing Went Wrong',
                  style: Theme.of(context).textTheme.bodyText1,
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}



class _PlayPause extends StatelessWidget {
  final AnimationController animationController;
  final void Function() onPressed;

  //final IconData icon;

  const _PlayPause(
      {Key? key, required this.onPressed, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.lightGreen),
        child: AnimatedIcon(
          color: AppColors.white,
          icon: AnimatedIcons.play_pause,
          progress: animationController,
        ),
      ),
    );
  }
}


