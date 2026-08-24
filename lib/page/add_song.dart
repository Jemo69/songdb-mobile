import 'package:flutter/material.dart';

import '../api/songdb.dart';
import '../models/song.dart';

class AddSongPage extends StatefulWidget {
  const AddSongPage({super.key, required this.api, this.onSaved});

  final SongDbApi api;
  final ValueChanged<Song>? onSaved;

  @override
  State<AddSongPage> createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _lyricsController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _lyricsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final song = await widget.api.createSong(
        title: _titleController.text.trim(),
        lyrics: _lyricsController.text.trim(),
      );
      widget.onSaved?.call(song);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${song.title}" saved to SongDB')),
      );
      Navigator.of(context).pop();
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
      setState(() => _saving = false);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not reach SongDB. Try again.')),
      );
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add song')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            children: [
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.sentences,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'e.g. Amazing Grace - John Newton',
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Give the song a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lyricsController,
                maxLines: 12,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Lyrics',
                  alignLabelWithHint: true,
                  hintText: 'Verse 1\n…',
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: _saving ? null : _save,
                child: _saving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.4),
                      )
                    : const Text('Save song'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _saving ? null : () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
