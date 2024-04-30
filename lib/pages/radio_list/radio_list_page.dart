import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:radios/components/player_widget.dart';
import 'package:radios/pages/radio_list/cubit/radio_list_cubit.dart';
import 'package:radios/pages/radio_list/cubit/radio_list_state.dart';

class RadioListPage extends StatelessWidget {
  const RadioListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadioListCubit(),
      child: const _ExerciseListPage(),
    );
  }
}

class _ExerciseListPage extends StatelessWidget {
  const _ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFF4DA7DD),
            padding: const EdgeInsets.all(9),
            child: Column(
              children: [
                const Text('Bienvenue',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildSearchField(),
                const SizedBox(height: 8),
                _buildLocationFilterButton(),
              ],
            ),
          ),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/color_bg.jpg",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.matrix([
                    0.33, 0.59, 0.11, 0, 0, // red channel
                    0.33, 0.59, 0.11, 0, 0, // green channel
                    0.33, 0.59, 0.11, 0, 0, // blue channel
                    0, 0, 0, 0.5, 0, // alpha channel
                  ]),
                ),
              ),
              child: Column(
                children: [
                  Expanded(child: _buildListView()),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: PlayerWidget(),
    );
  }
}

Widget _buildListView() {
  return BlocBuilder<RadioListCubit, RadioListState>(
    builder: (context, state) {
      final player = Provider.of<AudioPlayer>(context);
      if (state is RadioListLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is RadioListLoaded) {
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: state.filteredRadios
              .map(
                (radio) => Container(
                  padding: const EdgeInsets.all(16),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Set the background color to white
                        borderRadius: BorderRadius.circular(
                            20), // Set the shape to a circle
                        boxShadow: [
                          // Optional: Add a shadow for better visibility against other backgrounds
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AspectRatio(
                          aspectRatio: 1 /
                              1, // Depends on the aspect ratio of your image
                          child: Image.asset(
                            'assets/logos/${radio.logoFileName}',
                            fit: BoxFit.contain, // Adjust as necessary
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      final audioSource = AudioSource.uri(
                        Uri.parse(radio.streamlink),
                        tag: MediaItem(
                          id: radio.logoFileName,
                          // Metadata to display in the notification:
                          title: radio.logoFileName,
                          artUri:
                              Uri.parse('assets/logos/${radio.logoFileName}'),
                        ),
                      );
                      await player.setAudioSource(audioSource);
                      await player.play();
                    },
                  ),
                ),
              )
              .toList(),
        );
      } else if (state is RadioListError) {
        return Center(child: Text('Error: ${state.message}'));
      }
      return const Center(child: Text('No exercises found'));
    },
  );
}

Widget _buildSearchField() {
  return BlocBuilder<RadioListCubit, RadioListState>(
    builder: (context, state) {
      if (state is RadioListLoaded) {
        final border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextField(
            onChanged: (value) =>
                context.read<RadioListCubit>().updateTextFilter(value),
            decoration: InputDecoration(
              hintText: 'Rechercher une radio',
              filled: true,
              isDense: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(8),
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        );
      } else {
        return Container();
      }
    },
  );
}

Widget _buildLocationFilterButton() {
  return BlocBuilder<RadioListCubit, RadioListState>(
    builder: (context, state) {
      if (state is RadioListLoaded) {
        final isActive = state.positionFilter != null;
        return Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.pressed)
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent;
                },
              ),
            ),
            icon: Icon(isActive ? Icons.location_off : Icons.location_on),
            label:
                Text(isActive ? 'Toutes les radios' : 'Radios autour de moi'),
            onPressed: () =>
                context.read<RadioListCubit>().togglePositionFilter(),
          ),
        );
      } else {
        return Container();
      }
    },
  );
}

String _formatDate(DateTime date) {
  // Format the date as needed, e.g., dd/MM/yyyy
  return DateFormat('dd/MM/yyyy').format(date);
}
