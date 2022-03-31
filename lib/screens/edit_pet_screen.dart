import 'package:almighty_pet/models/pet.dart';
import 'package:almighty_pet/providers/pet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/location.dart';

class EditPetScreen extends StatefulWidget {
  static const routeName = '/edit-pet';

  @override
  _EditPetScreenState createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _form = GlobalKey<FormState>();

  var _editedPet = Pet(
      Location(latitude: 41.989948561073035, longitude: 21.486265197965615),
      false,
      id: DateTime.now().toString(),
      name: '',
      description: '',
      age: 0,
      category: PetCategory.non,
      breed: '',
      address: '',
      image: '',
      gender: Gender.non,
      date: '');

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {
    'location': '',
    'isFavorite': '',
    'name': '',
    'description': '',
    'age': '',
    'category': '',
    'breed': '',
    'address': '',
    'image': '',
    'gender': '',
    'date': ''
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final petId = ModalRoute.of(context)!.settings.arguments as String;
      if (petId != null) {
        final petToId =
        Provider.of<PetProvider>(context, listen: false).findById(petId);
        _editedPet = petToId;
        _initValues = {
          'name': _editedPet.name,
          'breed' : _editedPet.breed,
          'category' : _editedPet.category as String,
          'location' : _editedPet.location as String,
          'description': _editedPet.description,
          'age': _editedPet.age.toString(),
          'imageURL': '',
        };
        _imageUrlController.text = _editedPet.image;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          _imageUrlController.text.startsWith('http') ||
          _imageUrlController.text.endsWith('.png') ||
          _imageUrlController.text.endsWith('.jpg') ||
          _imageUrlController.text.endsWith('.jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveFormData() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedPet.id != null) {
      await Provider.of<PetProvider>(context, listen: false)
          .updatePet(_editedPet.id, _editedPet);
    } else {
      try {
        await Provider.of<PetProvider>(context, listen: false)
            .addPet(_editedPet);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text('Something went wrong'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Okay'))
                  ],
                ));
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveFormData,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['name'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _editedPet = Pet(
                            _editedPet.location, _editedPet.isFavorite,
                            id: _editedPet.id,
                            name: _editedPet.name,
                            description: _editedPet.description,
                            age: _editedPet.age,
                            category: _editedPet.category,
                            breed: _editedPet.breed,
                            address: _editedPet.address,
                            image: _editedPet.image,
                            gender: _editedPet.gender,
                            date: _editedPet.date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value!'; //error message
                        }
                        return null; //input is correct
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['age'] as String,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_nameFocusNode);
                      },
                      focusNode: _nameFocusNode,
                      onSaved: (value) {
                        _editedPet = Pet(
                            _editedPet.location, _editedPet.isFavorite,
                            id: _editedPet.id,
                            name: _editedPet.name,
                            description: _editedPet.description,
                            age: int.parse(value!),
                            category: _editedPet.category,
                            breed: _editedPet.breed,
                            address: _editedPet.address,
                            image: _editedPet.image,
                            gender: _editedPet.gender,
                            date: _editedPet.date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value!'; //error message
                        }
                        if (double.tryParse(value) != null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter number greater than 0';
                        }
                        return null; //input is correct
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'] as String,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedPet = Pet(
                            _editedPet.location, _editedPet.isFavorite,
                            id: _editedPet.id,
                            name: _editedPet.name,
                            description: value!,
                            age: _editedPet.age,
                            category: _editedPet.category,
                            breed: _editedPet.breed,
                            address: _editedPet.address,
                            image: _editedPet.image,
                            gender: _editedPet.gender,
                            date: _editedPet.date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value!'; //error message
                        }
                        if(value.length < 10){
                          return 'Please provide description with at least 10 characters!';
                        }
                        return null; //input is correct
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['address'] as String,
                      decoration: InputDecoration(
                        labelText: 'Address',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedPet = Pet(
                            _editedPet.location,
                            _editedPet.isFavorite,
                            id: _editedPet.id,
                            name: _editedPet.name,
                            description: _editedPet.description,
                            age: _editedPet.age,
                            category: _editedPet.category,
                            breed: _editedPet.breed,
                            address: value!,
                            image: _editedPet.image,
                            gender: _editedPet.gender,
                            date: _editedPet.date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value!'; //error message
                        }
                        return null; //input is correct
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['breed'] as String,
                      decoration: InputDecoration(
                        labelText: 'Breed',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedPet = Pet(
                            _editedPet.location,
                            _editedPet.isFavorite,
                            id: _editedPet.id,
                            name: _editedPet.name,
                            description: _editedPet.description,
                            age: _editedPet.age,
                            category: _editedPet.category,
                            breed: value!,
                            address: _editedPet.address,
                            image: _editedPet.image,
                            gender: _editedPet.gender,
                            date: _editedPet.date);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value!'; //error message
                        }
                        return null; //input is correct
                      },
                    ),
                    DropdownButton<PetCategory>(
                      hint: const Text('Select category for the pet'),
                     value: _initValues['category'] as PetCategory ,
                        onChanged: (newPetCategory){
                          setState(() {
                            _initValues['category'] = newPetCategory! as String;
                          });
                        },
                      icon: Icon(Icons.arrow_drop_down, color: Colors.blue,),
                        items : PetCategory.values.map((petItem){
                          return DropdownMenuItem(
                            value: petItem,
                              child: Text(petItem.toString()));
                        }).toList()
                        ),
                    DropdownButton<Gender>(
                        hint: const Text('Select category for the pet'),
                        value: _initValues['gender'] as Gender ,
                        onChanged: (newPetCategory){
                          setState(() {
                            _initValues['category'] = newPetCategory! as String;
                          });
                        },
                        icon: Icon(Icons.arrow_drop_down, color: Colors.blue,),
                        items : Gender.values.map((petItem){
                          return DropdownMenuItem(
                              value: petItem,
                              child: Text(petItem.toString()));
                        }).toList()
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL for image')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //initialValue: _initValues['imageURL'],
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveFormData();
                            },
                            onSaved: (value) {
                              _editedPet = Pet(
                                  _editedPet.location, _editedPet.isFavorite,
                                  id: _editedPet.id,
                                  name: _editedPet.name,
                                  description: _editedPet.description,
                                  age: _editedPet.age,
                                  category: _editedPet.category,
                                  breed: _editedPet.breed,
                                  address: _editedPet.address,
                                  image: value!,
                                  gender: _editedPet.gender,
                                  date: _editedPet.date);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value!'; //error message
                              }
                              if (!value.startsWith('http') ||
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL';
                              }
                              if (!value.endsWith('.png') ||
                                  !value.endsWith('.jpg') ||
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL';
                              }
                              return null; //input is correct
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
