import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';

class CheckboxPage extends ScrollablePage {
  bool firstChecked = false;
  bool firstDisabled = false;
  bool? secondChecked = false;
  bool secondDisabled = false;
  bool iconDisabled = false;

  @override
  Widget buildHeader(BuildContext context) {
    return const PageHeader(title: Text('Checkbox'));
  }

  @override
  List<Widget> buildScrollable(BuildContext context) {
    return [
      const Text(
        'CheckBox controls let the user select a combination of binary options. In contrast, RadioButton controls allow the user to select from mutually exclusive options. The indeterminate state is used to indicate that an option is set for some, but not all, child options. Don\'t allow users to set an indeterminate state directly to indicate a third option.',
      ),
      subtitle(content: const Text('A 2-state Checkbox')),
      CardHighlight(
        child: Row(children: [
          Checkbox(
            checked: firstChecked,
            onChanged: firstDisabled
                ? null
                : (v) {
                    setState(() {
                      firstChecked = v!;
                    });
                  },
            content: const Text('Two-state Checkbox'),
          ),
          const Spacer(),
          ToggleSwitch(
            checked: firstDisabled,
            onChanged: (v) {
              setState(() {
                firstDisabled = v;
              });
            },
            content: const Text('Disabled'),
          ),
        ]),
        codeSnippet: '''bool checked = false;

Checkbox(
  checked: checked,
  onPressed: disabled ? null : (v) => setState(() => checked = v),
)''',
      ),
      subtitle(content: const Text('A 3-state Checkbox')),
      CardHighlight(
        child: Row(children: [
          Checkbox(
            checked: secondChecked,
            // checked: null,
            onChanged: secondDisabled
                ? null
                : (v) {
                    setState(() {
                      secondChecked = v == true
                          ? true
                          : v == false
                              ? null
                              : v == null
                                  ? false
                                  : true;
                    });
                  },
            content: const Text('Three-state Checkbox'),
          ),
          const Spacer(),
          ToggleSwitch(
            checked: secondDisabled,
            onChanged: (v) {
              setState(() {
                secondDisabled = v;
              });
            },
            content: const Text('Disabled'),
          ),
        ]),
        codeSnippet: '''bool checked = false;

Checkbox(
  checked: checked,
  onPressed: disabled ? null : (v) {
    setState(() {
      // if v (the new value) is true, then true
      // if v is false, then null (third state)
      // if v is null (was third state before), then false
      // otherwise (just to be safe), it's true
      checked = (v == true
        ? true
          : v == false
            ? null
              : v == null
                ? false
                  : true);
    });
  },
)''',
      ),
      subtitle(
        content: const Text('Using a 3-state Checkbox (TreeView)'),
      ),
      Card(
        child: TreeView(
          items: [
            TreeViewItem(
              content: const Text('Select all'),
              children: [
                TreeViewItem(content: const Text('Option 1')),
                TreeViewItem(content: const Text('Option 2')),
                TreeViewItem(content: const Text('Option 3')),
              ],
            ),
          ],
          selectionMode: TreeViewSelectionMode.multiple,
        ),
      ),
    ];
  }
}
