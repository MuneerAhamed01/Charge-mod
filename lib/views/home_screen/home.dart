import 'package:carousel_slider/carousel_slider.dart';
import 'package:charge_mod/utils/assets.dart';
import 'package:charge_mod/utils/colors.dart';
import 'package:charge_mod/views/home_screen/bloc/location_bloc/location_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageAssets.map,
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is! LocationSuccessState) return const SizedBox();
            return Align(
              alignment: Alignment.bottomCenter,
              child: CarouselSlider(
                options: CarouselOptions(height: 191.0, viewportFraction: 1),
                items: state.location.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 100,
                          left: 27,
                          right: 27,
                          top: 30,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          width: MediaQuery.of(context).size.width,
                          height: 42,
                          decoration: BoxDecoration(
                            color: ColorTheme.commonWhite,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.25),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                        maxLines: 1,
                                overflow: TextOverflow.ellipsis,

                              ),
                              Text(
                                i.locationString,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: const Color(0xff534B4A)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
