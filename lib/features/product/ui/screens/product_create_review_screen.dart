import 'package:ecommerce/features/product/ui/screens/product_review_list.dart';
import 'package:flutter/material.dart';

class ProductCreateReviewScreen extends StatefulWidget {
  const ProductCreateReviewScreen({super.key});

  static const String name = '/product/create-review';

  @override
  State<ProductCreateReviewScreen> createState() =>
      _ProductCreateReviewScreenState();
}

class _ProductCreateReviewScreenState extends State<ProductCreateReviewScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();

  final TextEditingController _writeReviewTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              _buildForm(),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductReviewList(),
                    ),
                  );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameTEController,
            decoration: const InputDecoration(hintText: 'First Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid First Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _lastNameTEController,
            decoration: const InputDecoration(hintText: 'Last Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Last Name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextFormField(
            maxLines: 8,
            controller: _writeReviewTEController,
            decoration: const InputDecoration(hintText: 'Write Review'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter valid Review';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _writeReviewTEController.dispose();

    super.dispose();
  }
}
