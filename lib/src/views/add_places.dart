import 'dart:io';
import 'package:nearme/src/model/place.dart';
import 'package:flutter/material.dart';
import 'package:nearme/src/provider/user_places_provider.dart';
import '../model/image_input.dart';
import '../model/location_input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }
    ref
        .read(userPlacesProvider.notifier)
        .addPlaces(enteredText, _selectedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('home');
                      },
                      icon: const Icon(Icons.arrow_back,size:30,)),
                  const Text('Add new place',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ],
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              ImageInput(onPickImage: (image) {
                _selectedImage = image;
              }),
              const SizedBox(height: 10),
              LocationInput(onSelectLocation: (location) {
                _selectedLocation = location;
              }),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                onPressed: (){
                  Navigator.of(context).popAndPushNamed('home');
                },
                label: const Text('Add Place'),
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
