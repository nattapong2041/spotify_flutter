part of '../playlist_detail_screen.dart';

class _AddTrackBottomsheet extends StatelessWidget {
  final Function(String trackId) onAddTrack;
  const _AddTrackBottomsheet({super.key, required this.onAddTrack});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text(
            "เพิ่มเพลงให้เพลย์ลิสต์ของคุณ",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppConstant.paddingMedium),
        ListTile(
            leading: const AppUrlImage(
              "https://i.scdn.co/image/ab67616d0000b27335f6c397ed1d0ce4f3234de8",
              width: 50,
              height: 50,
            ),
            title: const Text("รักแรกพบ"),
            subtitle: const Text("Tattoo Colour"),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onAddTrack("spotify:track:19VIBTwlLTX2SKK6e3erAf");
              },
            )),
        ListTile(
            leading: const AppUrlImage(
              "https://i.scdn.co/image/ab67616d0000b273eaac2a7955f5b8967991cacb",
              width: 50,
              height: 50,
            ),
            title: const Text("Die For You"),
            subtitle: const Text("Joji"),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onAddTrack("spotify:track:26hOm7dTtBi0TdpDGl141t");
              },
            )),
        ListTile(
            leading: const AppUrlImage(
              "https://i.scdn.co/image/ab67616d0000b27381052badd62d5e14c3377786",
              width: 50,
              height: 50,
            ),
            title: const Text("Mayonaka no Door / Stay With Me"),
            subtitle: const Text("Miki Matsubara"),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onAddTrack("spotify:track:2BHj31ufdEqVK5CkYDp9mA");
              },
            )),
      ],
    );
  }
}
