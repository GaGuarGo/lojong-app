import 'package:flutter/material.dart';

class Styles {
  //Cores

  final grayColor = const Color(0xFF80848F);
  final lightGrayColor = const Color(0xFFECECEC);
  final dividerColor = const Color(0xFF979797);
  final cardColor = const Color(0xFFEBEBEB);
  final blueCardTextColor = const Color(0xFF446DAF);
  final yellowCardTextColor = const Color(0xFF000000).withOpacity(0.3);
  final redCardTextColor = const Color(0xFF000000).withOpacity(0.3);

  //Degrades

  final blueGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF8DC1E9).withOpacity(0.9),
        const Color(0xFFFFFFFF).withOpacity(0.9),
      ]);

  final yellowGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFFE8D5A2).withOpacity(0.9),
        const Color(0xFFF3B093).withOpacity(0.9),
      ]);

  final pinkGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xffE69681),
        Color(0xffDC8D9B),
      ]);

  //Estilos do texto das Citações

  final blueQuoteTextStyle =
      const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF446DAF));
  final yellowQuoteTextStyle =
      const TextStyle(fontWeight: FontWeight.w600, color: Colors.black38);
  final redQuoteTextStyle =
      const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF));

  //Estilo do texto do autor das Citações

  final blueAuthorTitle = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Color(0xFF446DAF),
    fontSize: 14,
  );

  final blueAuthorTitleTablet = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Color(0xFF446DAF),
    fontSize: 18,
  );

  final yellowAuthorTitle = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Colors.black38,
    fontSize: 14,
  );

  final yellowAuthorTitleTablet = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Colors.black38,
    fontSize: 18,
  );

  final redAuthorTitle = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    fontSize: 14,
  );

  final redAuthorTitleTablet = const TextStyle(
    fontFamily: 'Asap',
    fontWeight: FontWeight.w600,
    color: Color(0xFFFFFFFF),
    fontSize: 18,
  );

  //Estilo do textos dos videos e artigos

  final title = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Color(0xFF80848F));
  final titleTablet = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: Color(0xFF80848F));
  final subtTitle = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Color(0xFF80848F));
  final subtTitleTablet = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w400,
      fontSize: 20,
      color: Color(0xFF80848F));

  //Estilos dos botões de compartilhar

  final buttonTitle = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 12.3,
      color: Color(0xFF80848F));
  final buttonTitleTablet = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Color(0xFF80848F));
  final quoteButtonTitle = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 12.3,
      color: Colors.white);
  final quoteButtonTitleTablet = const TextStyle(
      fontFamily: 'Asap',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Colors.white);
}
