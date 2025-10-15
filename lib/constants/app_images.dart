// path: lib/constants/app_images.dart
// Centralized raster asset paths for Image.asset lookups.
// Contract: widgets must only use AppImages.* (no raw 'assets/...').
// Source of truth: assets_list.md (inventory) and PRD (required UI parts).
//
// Inventory list (assets_list.md) includes all lines below. :contentReference[oaicite:0]{index=0}
// PRD also references a subset of these for specific screens. :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}

abstract final class AppImages {
  AppImages._();

  // Backgrounds
  static const String backgroundMenu = 'assets/images/background_menu.png';
  static const String backgroundGame = 'assets/images/background_game.png';
  static const String backgroundDialog0 =
      'assets/images/background_dialog0.png';
  static const String backgroundDialog1 =
      'assets/images/background_dialog1.png';

  // Loading / progress
  static const String candyStatic = 'assets/images/candy_static.png';
  static const String progressFrame = 'assets/images/progress_frame.png';
  static const String progressFill = 'assets/images/progress_fill.png';

  // Main menu
  static const String mainScoreBanner = 'assets/images/main_score_banner.png';
  static const String btnLarge = 'assets/images/btn_large.png';

  // Settings controls
  static const String settingsPanel = 'assets/images/settings_panel.png';
  static const String btnBack = 'assets/images/btn_back.png';
  static const String btnSmall = 'assets/images/btn_small.png';
  static const String checkboxChecked = 'assets/images/checkbox_checked.png';
  static const String checkboxUnchecked =
      'assets/images/checkbox_unchecked.png';
  static const String sliderTrack = 'assets/images/slider_track.png';
  static const String sliderBack = 'assets/images/slider_back.png';
  static const String sliderThumb = 'assets/images/slider_thumb.png';
  static const String decorCandy1 = 'assets/images/decor_candy1.png';
  static const String decorCandy2 = 'assets/images/decor_candy2.png';

  // Decorative elements / panels
  static const String decorCandy3 = 'assets/images/decor_candy3.png';
  static const String infoPanel = 'assets/images/info_panel.png';
  static const String scrollBarTrack = 'assets/images/scroll_bar_track.png';
  static const String scrollBarThumb = 'assets/images/scroll_bar_thumb.png';
  static const String infoItemBg = 'assets/images/info_item_bg.png';

  // Candies (info list & gameplay)
  static const String candyBlueSwirl = 'assets/images/candy_blue_swirl.png';
  static const String candyPinkSwirl = 'assets/images/candy_pink_swirl.png';
  static const String candySkyBlue = 'assets/images/candy_sky_blue.png';
  static const String candyGreen = 'assets/images/candy_green.png';
  static const String candyPurple = 'assets/images/candy_purple.png';
  static const String candyCool = 'assets/images/candy_cool.png';
  static const String candyTurquoise = 'assets/images/candy_turquoise.png';
  static const String candyYellow = 'assets/images/candy_yellow.png';
  static const String candyRed = 'assets/images/candy_red.png';
  static const String candyPuple =
      'assets/images/candy_puple.png'; // Note: inventory spelling

  // Characters / misc UI
  static const String characterPink = 'assets/images/character_pink.png';
  static const String characterBlue = 'assets/images/character_blue.png';
  static const String scorePanel = 'assets/images/score_panel.png';
  static const String nextCandyPanel = 'assets/images/next_candy_panel.png';
  static const String gameFrame = 'assets/images/game_frame.png';
  static const String tapHintHand = 'assets/images/tap_hint_hand.png';
  static const String candiesBar = 'assets/images/candies_bar.png';
  static const String topLine = 'assets/images/top_line.png';
  static const String characterLeft = 'assets/images/character_left.png';
  static const String chupachupsBig = 'assets/images/chupachups_big.png';

  // Dialogs & buttons in-game
  static const String dialogWin = 'assets/images/dialog_win.png';
  static const String dialogLose = 'assets/images/dialog_lose.png';
  static const String btnRetry = 'assets/images/btn_retry.png';
  static const String btnGetBonus = 'assets/images/btn_get_bonus.png';

  // Icons
  static const String iconStar = 'assets/images/icon_star.png';
}
