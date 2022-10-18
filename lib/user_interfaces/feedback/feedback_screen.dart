import 'package:droidcon_app/styles/colors/colors.dart';
import 'package:droidcon_app/user_interfaces/widgets/app_back_button.dart';
import 'package:droidcon_app/user_interfaces/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../authentication/widgets/signup_image_background.dart';
import 'feedback_rating.dart';

class FeedbackScreen extends StatefulWidget {
  static String routeName = 'feedback';

  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            leading: AppBackButton(),
            title: Text('Feedback'),
            expandedHeight: 180.0,
            backgroundColor: AppColors.blueColor,
            flexibleSpace: FlexibleSpaceBar(
              background: SignUpSVGBackground(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FormBuilder(
                    key: formKey,
                    child: Column(children: [
                      const SizedBox(height: 30),
                      Text(
                        'Your feedback helps us improve',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: AppColors.blueColor,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 1,
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              const SizedBox(height: 17),
                              Text(
                                'How is/was the event',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 30),
                              FormBuilderField<String>(
                                builder: (field) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                      errorText: field.errorText,
                                      fillColor: Colors.transparent,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    child: FeedbackRating(
                                      onValueChanged: (value) =>
                                          field.didChange(value),
                                    ),
                                  );
                                },
                                name: 'feedback',
                                validator: FormBuilderValidators.required(),
                              ),
                              const SizedBox(height: 27),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FormBuilderTextField(
                        name: 'info',
                        decoration: const InputDecoration(
                          hintText: 'Type message here',
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.maxFinite,
                        child: PrimaryButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              // TODO: Submit value
                              await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Text(
                                      'Thank you for your feedback',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  actions: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: PrimaryButton(
                                        label: 'OKAY',
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              if (mounted) {
                                context.pop();
                              }
                            }
                          },
                          label: 'Submit Feedback'.toUpperCase(),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}