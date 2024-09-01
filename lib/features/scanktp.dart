// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcReaderktp extends StatefulWidget {
  @override
  _NfcReaderktpState createState() => _NfcReaderktpState();
}

class _NfcReaderktpState extends State<NfcReaderktp> {
  String _nfcData = "Tap your KTP to the phone";

  @override
  void initState() {
    super.initState();
    _startNfcSession();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  Future<void> _startNfcSession() async {
    try {
      // Memulai sesi NFC
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          // Mendapatkan serial number dari tag NFC (e-KTP)
          var nfcTech = tag.data['nfca'] ??
              tag.data['nfcb'] ??
              tag.data['nfcf'] ??
              tag.data['nfcv'];
          if (nfcTech != null) {
            String serialNumber = nfcTech['identifier']
                .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
                .join('')
                .toUpperCase();
            setState(() {
              _nfcData = "Serial Number: $serialNumber";
            });
          } else {
            setState(() {
              _nfcData = "No serial number found.";
            });
          }
          // Mengakhiri sesi NFC setelah data dibaca
          NfcManager.instance.stopSession();
        },
      );
    } catch (e) {
      setState(() {
        _nfcData = "Failed to read NFC: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KTP Reader'),
      ),
      body: Center(
        child: Text(_nfcData),
      ),
    );
  }
}
