part of '../playlist_me_screen.dart';

class _CreatePlayListBottomSheet extends StatefulWidget {
  final Function(String name) onCreated;
  const _CreatePlayListBottomSheet({required this.onCreated});

  @override
  State<_CreatePlayListBottomSheet> createState() => _CreatePlayListBottomSheetState();
}

class _CreatePlayListBottomSheetState extends State<_CreatePlayListBottomSheet> {
  bool isButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          setState(() {
            isButtonEnabled = _formKey.currentState?.validate() ?? false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.paddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ตั้งชื่อให้เพลย์ลิสต์ของคุณ",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppConstant.paddingLarge * 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstant.paddingMedium),
                child: TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "ชื่อเพลย์ลิสต์",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "กรุณากรอกชื่อเพลย์ลิสต์";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    widget.onCreated(newValue!);
                  },
                ),
              ),
              const SizedBox(height: AppConstant.paddingLarge * 3),
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState!.save();
                        }
                      }
                    : null,
                child: const Text("สร้าง"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
