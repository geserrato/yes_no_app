import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: _ChatView(),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://imgs.search.brave.com/NWn4UNLKLsjx6eYZ3KkKT3MaiaAhLfzE4Y5zuL2M4TI/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9jZWxl/Ym1hZmlhLmNvbS93/cC1jb250ZW50L3Vw/bG9hZHMvMjAxNC8w/NS9rYXRoZXJ5bi13/aW5uaWNrLWF0dGVu/ZHMtdGhlLTIwMTQt/YWUtbmV0d29ya3Mt/dXBmcm9udC1wYXJr/LWF2ZW51ZS1hcm1v/cnktbmV3LXlvcmst/Y2l0eV8xLmpwZw'),
        ),
      ),
      title: const Text('Katheryn Winnick'),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final Message message = chatProvider.messages[index];
                    return (message.fromWho == FromWho.hers)
                        ? const HerMessageBubble()
                        : MyMessageBubble(message: message);
                  }),
            ),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}
