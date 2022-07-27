import "package:app/modules/raffle/infra/models/raffle-winner.model.dart";
import "package:app/utils/functions.dart";
import "package:app/utils/widgets/loader/shimmer-wrapper.widget.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:styled_widget/styled_widget.dart";

class LastWinnerListTile extends StatelessWidget {
  final RaffleWinnerModel winner;
  final bool selected;

  const LastWinnerListTile({
    Key? key,
    required this.winner,
    this.selected = false,
  }) : super(key: key);

  static Widget shimmer() {
    var title = Container(width: 80, height: 16, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ShimmerWrapper(
          child: [
            Container(width: 40, height: 40, color: Colors.white)
              .clipRRect(all: 99),
            [
              title,
              title.width(120),
              title.width(100)
            ].toColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              separator: const SizedBox(height: 3)
            )
          ].toRow(separator: const SizedBox(width: 18))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      trailing: Text("#${winner.position}"),
      leading: CachedNetworkImage(
        width: 40,
        height: 40,
        imageUrl: "https://evoverse-images.s3.us-west-2.amazonaws.com/pro/${winner.playerId}.jpg",
        httpHeaders: const {
          "Referer": "https://farming.evoverse.app/"
        },
        imageBuilder: (_, provider) => CircleAvatar(
          backgroundImage: provider,
        ),
        placeholder: (_, __) {
          return ShimmerWrapper(
              child: Container(color: Colors.white).clipRRect(all: 99)
          );
        },
        errorWidget: (_, __, ___) => Image.asset(asset("images/avatar_placeholder.png")),
      ),
      title: Text(winner.playerName),
      subtitle: Wrap(
        direction: Axis.vertical,
        children: List<Widget>
            .from(winner.rewards.map((reward) {
          return Text("${reward.amount}x ${reward.name}");
        })),
      )
    );
  }
}
