import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String _hex(Color color) {
  if (color == Colors.transparent) return 'none';
  final value = color.toARGB32();
  return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}

abstract final class MBIconsActions {
  static Widget trash({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget trashFilled({Color color = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke-width="2.5">
        <path d="M20 9L18.005 20.3463C17.8369 21.3026 17.0062 22 16.0353 22H7.96474C6.99379 22 6.1631 21.3026 5.99496 20.3463L4 9" fill="${_hex(color)}"/>
        <path d="M20 9L18.005 20.3463C17.8369 21.3026 17.0062 22 16.0353 22H7.96474C6.99379 22 6.1631 21.3026 5.99496 20.3463L4 9H20Z" stroke="${_hex(color)}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M21 6H15.375M3 6H8.625M8.625 6V4C8.625 2.89543 9.52043 2 10.625 2H13.375C14.4796 2 15.375 2.89543 15.375 4V6M8.625 6H15.375" stroke="${_hex(color)}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget share({Color color = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="2.5" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M20 13V19C20 20.1046 19.1046 21 18 21H6C4.89543 21 4 20.1046 4 19V13" stroke="${_hex(color)}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 15V3M12 3L8.5 6.5M12 3L15.5 6.5" stroke="${_hex(color)}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget enter({Color color = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" viewBox="0 0 24 24" stroke-width="2.5" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M1.25 6C1.25 3.92894 2.92894 2.25 5 2.25H7C9.07106 2.25 10.75 3.92894 10.75 6V18C10.75 20.0711 9.07106 21.75 7 21.75H5C2.92894 21.75 1.25 20.0711 1.25 18V6Z" fill="${_hex(color)}"/>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M15.25 3C15.25 2.58579 15.5858 2.25 16 2.25H18C20.6233 2.25 22.75 4.37664 22.75 7V17C22.75 19.6233 20.6233 21.75 18 21.75H16C15.5858 21.75 15.25 21.4142 15.25 21C15.25 20.5858 15.5858 20.25 16 20.25H18C19.7949 20.25 21.25 18.7949 21.25 17V7C21.25 5.20508 19.7949 3.75 18 3.75H16C15.5858 3.75 15.25 3.41421 15.25 3Z" fill="${_hex(color)}"/>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M14.4697 8.46967C14.7626 8.17678 15.2374 8.17678 15.5303 8.46967L18.5303 11.4697C18.8232 11.7626 18.8232 12.2374 18.5303 12.5303L15.5303 15.5303C15.2374 15.8232 14.7626 15.8232 14.4697 15.5303C14.1768 15.2374 14.1768 14.7626 14.4697 14.4697L16.1893 12.75H10C9.58579 12.75 9.25 12.4142 9.25 12C9.25 11.5858 9.58579 11.25 10 11.25H16.1893L14.4697 9.53033C14.1768 9.23744 14.1768 8.76256 14.4697 8.46967Z" fill="${_hex(color)}"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget link({Color color = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.5" stroke="${_hex(color)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M13.19 8.688a4.5 4.5 0 0 1 1.242 7.244l-4.5 4.5a4.5 4.5 0 0 1-6.364-6.364l1.757-1.757m13.35-.622 1.757-1.757a4.5 4.5 0 0 0-6.364-6.364l-4.5 4.5a4.5 4.5 0 0 0 1.242 7.244"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget search({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget shieldCheck({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.5" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75m-3-7.036A11.959 11.959 0 0 1 3.598 6 11.99 11.99 0 0 0 3 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget refresh({Color strokeColor = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0 3.181 3.183a8.25 8.25 0 0 0 13.803-3.7M4.031 9.865a8.25 8.25 0 0 1 13.803-3.7l3.181 3.182m0-4.991v4.99"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget eye({Color strokeColor = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178Z"/>
        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget eyeSlash({Color strokeColor = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget squareFour({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25a2.25 2.25 0 0 1-2.25-2.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget backspace({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9.75 14.25 12m0 0 2.25 2.25M14.25 12l2.25-2.25M14.25 12 12 14.25m-2.58 4.92-6.374-6.375a1.125 1.125 0 0 1 0-1.59L9.42 4.83c.21-.211.497-.33.795-.33H19.5a2.25 2.25 0 0 1 2.25 2.25v10.5a2.25 2.25 0 0 1-2.25 2.25h-9.284c-.298 0-.585-.119-.795-.33Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget play({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 5.653c0-.856.917-1.398 1.667-.986l11.54 6.347a1.125 1.125 0 0 1 0 1.972l-11.54 6.347a1.125 1.125 0 0 1-1.667-.986V5.653Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget stop({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 7.5A2.25 2.25 0 0 1 7.5 5.25h9a2.25 2.25 0 0 1 2.25 2.25v9a2.25 2.25 0 0 1-2.25 2.25h-9a2.25 2.25 0 0 1-2.25-2.25v-9Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget chatBubbleDouble({
    Color strokeColor = Colors.transparent,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 8.511c.884.284 1.5 1.128 1.5 2.097v4.286c0 1.136-.847 2.1-1.98 2.193-.34.027-.68.052-1.02.072v3.091l-3-3c-1.354 0-2.694-.055-4.02-.163a2.115 2.115 0 0 1-.825-.242m9.345-8.334a2.126 2.126 0 0 0-.476-.095 48.64 48.64 0 0 0-8.048 0c-1.131.094-1.976 1.057-1.976 2.192v4.286c0 .837.46 1.58 1.155 1.951m9.345-8.334V6.637c0-1.621-1.152-3.026-2.76-3.235A48.455 48.455 0 0 0 11.25 3c-2.115 0-4.198.137-6.24.402-1.608.209-2.76 1.614-2.76 3.235v6.226c0 1.621 1.152 3.026 2.76 3.235.577.075 1.157.14 1.74.194V21l4.155-4.155"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget thumbsUp({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" fill="${_hex(fillColor)}" viewBox="0 0 24 24" stroke-width="2.0" stroke="${_hex(strokeColor)}">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6.633 10.25c.806 0 1.533-.446 2.031-1.08a9.041 9.041 0 0 1 2.861-2.4c.723-.384 1.35-.956 1.653-1.715a4.498 4.498 0 0 0 .322-1.672V2.75a.75.75 0 0 1 .75-.75 2.25 2.25 0 0 1 2.25 2.25c0 1.152-.26 2.243-.723 3.218-.266.558.107 1.282.725 1.282m0 0h3.126c1.026 0 1.945.694 2.054 1.715.045.422.068.85.068 1.285a11.95 11.95 0 0 1-2.649 7.521c-.388.482-.987.729-1.605.729H13.48c-.483 0-.964-.078-1.423-.23l-3.114-1.04a4.501 4.501 0 0 0-1.423-.23H5.904m10.598-9.75H14.25M5.904 18.5c.083.205.173.405.27.602.197.4-.078.898-.523.898h-.908c-.889 0-1.713-.518-1.972-1.368a12 12 0 0 1-.521-3.507c0-1.553.295-3.036.831-4.398C3.387 9.953 4.167 9.5 5 9.5h1.053c.472 0 .745.556.5.96a8.958 8.958 0 0 0-1.302 4.665c0 1.194.232 2.333.654 3.375Z"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget edit({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="2.0" viewBox="0 0 24 24" fill="${_hex(fillColor)}" xmlns="http://www.w3.org/2000/svg">
        <path d="M3 21L12 21H21" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12.2218 5.82839L15.0503 2.99996L20 7.94971L17.1716 10.7781M12.2218 5.82839L6.61522 11.435C6.42769 11.6225 6.32233 11.8769 6.32233 12.1421L6.32233 16.6776L10.8579 16.6776C11.1231 16.6776 11.3774 16.5723 11.565 16.3847L17.1716 10.7781M12.2218 5.82839L17.1716 10.7781" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget helpSquare({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="2.0" viewBox="0 0 24 24" fill="${_hex(fillColor)}" xmlns="http://www.w3.org/2000/svg">
        <path d="M9 9C9 5.49997 14.5 5.5 14.5 9C14.5 11.5 12 10.9999 12 13.9999" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 18.01L12.01 17.9989" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M3 20.4V3.6C3 3.26863 3.26863 3 3.6 3H20.4C20.7314 3 21 3.26863 21 3.6V20.4C21 20.7314 20.7314 21 20.4 21H3.6C3.26863 21 3 20.7314 3 20.4Z" stroke="${_hex(strokeColor)}" stroke-width="2.0"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget helpCircle({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="2.0" viewBox="0 0 24 24" fill="${_hex(fillColor)}" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M9 9C9 5.49997 14.5 5.5 14.5 9C14.5 11.5 12 10.9999 12 13.9999" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 18.01L12.01 17.9989" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget infoCircle({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="2.0" viewBox="0 0 24 24" fill="${_hex(fillColor)}" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 11.5V16.5" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 7.51L12.01 7.49889" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="${_hex(strokeColor)}" stroke-width="2.0" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget infoCircleSolid({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" viewBox="0 0 24 24" fill="${_hex(fillColor)}" xmlns="http://www.w3.org/2000/svg" stroke-width="2.0">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M1.25 12C1.25 6.06294 6.06294 1.25 12 1.25C17.9371 1.25 22.75 6.06294 22.75 12C22.75 17.9371 17.9371 22.75 12 22.75C6.06294 22.75 1.25 17.9371 1.25 12ZM12 10.75C12.4142 10.75 12.75 11.0858 12.75 11.5V16.5C12.75 16.9142 12.4142 17.25 12 17.25C11.5858 17.25 11.25 16.9142 11.25 16.5V11.5C11.25 11.0858 11.5858 10.75 12 10.75ZM12.5675 8.00075C12.8446 7.69287 12.8196 7.21865 12.5117 6.94156C12.2038 6.66446 11.7296 6.68942 11.4525 6.99731L11.4425 7.00842C11.1654 7.3163 11.1904 7.79052 11.4983 8.06761C11.8062 8.34471 12.2804 8.31975 12.5575 8.01186L12.5675 8.00075Z" fill="${_hex(fillColor)}"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget searchBag({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="${_hex(fillColor)}" stroke="${_hex(strokeColor)}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M11.5 21h-2.926a3 3 0 0 1 -2.965 -2.544l-1.255 -8.152a2 2 0 0 1 1.977 -2.304h11.339a2 2 0 0 1 1.977 2.304l-.117 .761"/>
        <path d="M9 11v-5a3 3 0 0 1 6 0v5"/>
        <path d="M15 18a3 3 0 1 0 6 0a3 3 0 1 0 -6 0"/>
        <path d="M20.2 20.2l1.8 1.8"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget check({Color strokeColor = Colors.black, double size = 24}) {
    return SvgPicture.string(
      '''
      <svg width="24px" height="24px" stroke-width="3" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M5 13L9 17L19 7" stroke="${_hex(strokeColor)}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget checkboxSquareRounded({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="${_hex(fillColor)}" stroke="${_hex(strokeColor)}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M9 12l2 2l4 -4"/>
        <path d="M12 3c7.2 0 9 1.8 9 9c0 7.2 -1.8 9 -9 9c-7.2 0 -9 -1.8 -9 -9c0 -7.2 1.8 -9 9 -9"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget userDelete({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="${_hex(fillColor)}" stroke="${_hex(strokeColor)}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"/>
        <path d="M6 21v-2a4 4 0 0 1 4 -4h3.5"/>
        <path d="M22 22l-5 -5"/>
        <path d="M17 22l5 -5"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }

  static Widget filter({
    Color strokeColor = Colors.black,
    Color fillColor = Colors.transparent,
    double size = 24,
  }) {
    return SvgPicture.string(
      '''
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="${_hex(fillColor)}" stroke="${_hex(strokeColor)}" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M4 6h16"/>
        <path d="M6 12h12"/>
        <path d="M9 18h6"/>
      </svg>
      ''',
      width: size,
      height: size,
    );
  }
}
