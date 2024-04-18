import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
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
      appBar: AppBar(
        title: const Text('Radios'),
      ),
      body: Column(
        children: [
          Expanded(child: _buildListView()),
          const SizedBox(height: 20),
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
        return ListView.builder(
          itemCount: state.radios.length,
          itemBuilder: (context, index) {
            final radio = state.radios[index];
            return ListTile(
              leading: Image.asset('assets/logos/${radio.logoFileName}'),
              title: Text(radio.city),
              subtitle: Text(
                radio.website,
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  print("radio.streamLink");
                  print(radio.streamlink);
                  await player.setUrl(radio.streamlink);
                  player.play();
                },
                child: Text('>'),
              ),
            );
          },
        );
      } else if (state is RadioListError) {
        return Center(child: Text('Error: ${state.message}'));
      }
      return const Center(child: Text('No exercises found'));
    },
  );
}

String _formatDate(DateTime date) {
  // Format the date as needed, e.g., dd/MM/yyyy
  return DateFormat('dd/MM/yyyy').format(date);
}
