## 🎨 Стиль UI

* **Основні кольори застосунку**:

  * Білий `#FFFFFF`
  * Фіолетово-малиновий `#990071`
* **Шрифт**: `Baloo` (інтегрувати через `pubspec.yaml`)


## 🔧 Екран: **Loading Screen**

### 🧩 Призначення

Заставка, яка відображається під час завантаження. Включає просту анімацію карамельки, напис "LOADING" і прогрес-бар.

---

### 🖼️ Елементи UI

| Назва              | Тип                                | Опис                                                                           |
| ------------------ | ---------------------------------- | ------------------------------------------------------------------------------ |
| `backgroundMenu` | `Image.asset`                      | Повноекранне зображення (одне з кількох).                                      |
| `backgroundBlur`   | `BackdropFilter`                   | Накладає розмиття на фон (Gaussian blur).                                      |
| `rotatingCandy`    | `AnimatedRotation` + `Image.asset` | Анімоване обертання однієї картинки карамельки.                                |
| `loadingText`      | `Text`                             | Напис `LOADING`, стиль — шрифт Baloo, білий фон, розова тінь.                  |
| `progressBarFrame` | `Image.asset`                      | Рамка прогрес-бару.                                                            |
| `progressBarFill`  | `ClipRect` + `Image.asset`         | Заповнення прогрес-бару по `widthFactor`.                                      |

---

### 🔁 Анімації

* **Карамелька**: обертається нескінченно — `AnimatedRotation` або `TweenAnimationBuilder`.
* **Прогрес-бар**: плавно заповнюється в залежності від прогресу завантаження.

---


---

### 📦 Ресурси

| Назва файлу            | Тип   | Використання              |
| ---------------------- | ----- | ------------------------- |
| `background_menu.png` | image | Один із фонових варіантів |
| `candy_static.png`     | image | Єдина картинка карамельки |
| `progress_frame.png`   | image | Рамка прогрес-бару        |
| `progress_fill.png`    | image | Заповнення прогрес-бару   |
| `Baloo-Regular.ttf`    | font  | Основний шрифт інтерфейсу |

---

### ⚙️ Логіка екрану

* **Обертання карамельки** — нескінченне (360° кожні 1.5–2с).
* **Завантаження ресурсів**:

  * `images.loadAll([...])`, `audio.loadAll([...])`, `Flame.device.fullScreen()`, тощо.
  * Прогрес контролюється через таймер або справжнє завантаження.
* **Після завершення** — перехід на головний екран гри (`Navigator.pushReplacement`).

---

### ✅ Підсумки оновлень

| Зміна                               | ✅ Враховано |
| ----------------------------------- | ----------- |
| Обертання — одна картинка           | ✅           |
| `backgroundMenu` + blur           | ✅           |
| Стиль тільки `#FFFFFF` та `#990071` | ✅           |
| Шрифт — `Baloo`                     | ✅           |

---

✅ Окей. Нижче — **технічний опис екрану Main Menu**, оновлений згідно твоїх вказівок:

---

## 🔧 Екран: **Main Menu Screen**

### 🧩 Призначення

Це головний екран гри, з якого користувач може почати гру, переглянути інформацію або перейти до налаштувань.

---

### 🖼️ Елементи UI

| Назва              | Тип              | Опис                                                |
| ------------------ | ---------------- | --------------------------------------------------- |
| `backgroundMenu` | `Image.asset`    | Повноекранне зображення фону, як на Loading Screen. |
| `backgroundBlur`   | `BackdropFilter` | Розмиття поверх фону (Gaussian blur).               |
| `bestScoreBanner`  | `Image.asset`    | Картинка з банером і великим числом по центру.      |
| `bestScoreText`    | `Text`           | Цифра найкращого рахунку (білий фон, розова тінь).  |
| `btnPlay`          | `Image + Text`   | Кнопка Play — картинка + текст по центру.           |
| `btnInfo`          | `Image + Text`   | Кнопка Info.                                        |
| `btnSettings`      | `Image + Text`   | Кнопка Settings.                                    |

---

### 📦 Ресурси

| Назва файлу             | Тип   | Призначення                  |
| ----------------------- | ----- | ---------------------------- |
| `background_menu.png`  | image | Фонове зображення            |
| `main_score_banner.png` | image | Банер з написом `BEST SCORE` |
| `btn_play.png`          | image | Фон кнопки Play              |
| `btn_info.png`          | image | Фон кнопки Info              |
| `btn_settings.png`      | image | Фон кнопки Settings          |
| `Baloo-Regular.ttf`     | font  | Основний шрифт               |

---

### ⚙️ Логіка екрану

* Дані про найкращий рахунок зберігаються в `SharedPreferences` або `Hive` і підвантажуються при запуску.
* Натискання на кнопки:

  * `Play` → відкриває екран з Flame-грою (`GameWidget`).
  * `Info` → відкриває екран з описом гри/правилами.
  * `Settings` → відкриває екран налаштувань.

---

## 🔧 Екран: **Settings Screen**

### 🧩 Призначення

Екран керування налаштуваннями гри: вмикання/вимикання звуку, вибір рівня складності, підтвердження змін.

---

### 🖼️ Елементи UI

| Назва               | Тип                     | Опис                                          |
| ------------------- | ----------------------- | --------------------------------------------- |
| `backgroundMenu`    | `Image.asset`           | Повноекранне зображення фону                  |
| `backgroundBlur`    | `BackdropFilter`        | Розмиття поверх фону.                         |
| `settingsPanel`     | `Image.asset`           | Одна картинка — рамка з написом `SETTINGS`.   |
| `btnBackSmall`      | `ImageButton`           | Кнопка назад у верхньому лівому куті.         |
| `labelSound`        | `Text`                  | Напис `SOUND`.                                |
| `checkboxSoundOn`   | `Image.asset`           | Активний чекбокс (звук увімкнено).            |
| `checkboxSoundOff`  | `Image.asset`           | Неактивний чекбокс (звук вимкнено).           |
| `labelHardness`     | `Text`                  | Напис `HARDNESS`.                             |
| `customSliderTrack` | `Image.asset`           | Зображення треку (рейки) кастомного слайдера. |
| `customSliderThumb` | `Draggable Image.asset` | Ручка слайдера, яку можна пересувати.         |
| `btnOkSmall`        | `Image.asset + Text`    | Мала кнопка `OK` (окреме зображення).         |
| `decorCandy1`       | `Image.asset`           | Ліва декоративна карамель.                    |
| `decorCandy2`       | `Image.asset`           | Права декоративна карамель.                   |

---

### 📦 Ресурси

| Назва файлу              | Тип   | Призначення                    |
| ------------------------ | ----- | ------------------------------ |
| `background_menu.png`   | image | Фонове зображення              |
| `settings_panel.png`     | image | Панель з заголовком `SETTINGS` |
| `btn_back_small.png`     | image | Кнопка назад                   |
| `checkbox_checked.png`   | image | Активний чекбокс               |
| `checkbox_unchecked.png` | image | Неактивний чекбокс             |
| `slider_track.png`       | image | Трек слайдера                  |
| `slider_thumb.png`       | image | Ручка слайдера                 |
| `btn_small.png`          | image | Кнопка `OK` (мала версія)      |
| `decor_candy1.png`       | image | Декорація ліва                 |
| `decor_candy2.png`       | image | Декорація права                |

---

### ⚙️ Логіка екрану

* **Кнопка назад (`btnBackSmall`)**
  Повертає користувача на `Main Menu`.

* **Чекбокс Sound**

  * Тап змінює стан між `checkbox_checked` і `checkbox_unchecked`.
  * Стан зберігається у локальному сховищі (`SharedPreferences`).

* **Слайдер Hardness**

  * Кастомний, із фіксованими кроками (наприклад, 1–5).
  * Керування рухом ручки (`slider_thumb.png`) за допомогою `GestureDetector`.
  * Позиція обмежена межами треку.
  * Логіку обробки поки не добавляємо, добавлю пізніше

* **Кнопка OK (`btnOkSmall`)**

  * Зберігає поточні налаштування (sound, hardness).
  * Повертає користувача на `Main Menu`.

---


## 🔧 Екран: **Info Screen**

### 🧩 Призначення

Екран показує інформацію про всі види ігрових карамельок — їх назву та короткий опис. Використовується для ознайомлення гравця з візуальними елементами гри.

---

### 🖼️ Елементи UI

| Назва             | Тип                     | Опис                                                           |
| ----------------- | ----------------------- | -------------------------------------------------------------- |
| `backgroundMenu`  | `Image.asset`           | Повноекранне зображення фону                                   |
| `backgroundBlur`  | `BackdropFilter`        | Розмиття поверх фону.                                          |
| `infoPanel`       | `Image.asset`           | Рамка з банером і написом `INFO`.                              |
| `btnBackSmall`    | `ImageButton`           | Кнопка назад (верхній лівий кут).                              |
| `customScrollBar` | `CustomPaint` / `Stack` | Вертикальний кастомний скрол (праворуч).                       |
| `decorCandy1`     | `Image.asset`           | Ліва нижня карамель-декорація.                                 |
| `decorCandy3`     | `Image.asset`           | Права нижня карамель-декорація.                                |
| `infoItem`        | Кастомний віджет        | Один блок із рамкою, зображенням карамельки, назвою і текстом. |

---

### 📦 Ресурси

| Назва файлу            | Тип   | Призначення                              |
| ---------------------- | ----- | ---------------------------------------- |
| `background_menu.png`  | image | Фонове зображення                        |
| `info_panel.png`       | image | Рамка з заголовком `INFO`                |
| `btn_back_small.png`   | image | Кнопка назад                             |
| `scroll_bar_track.png` | image | Основний трек кастомного скролу (якщо є) |
| `scroll_bar_thumb.png` | image | Рухома частина скролу                    |
| `decor_candy1.png`     | image | Ліва нижня декорація                     |
| `decor_candy3.png`     | image | Права нижня декорація                    |
| `info_item_bg.png`     | image | Рамка для кожного блоку інформації       |
| `candy_blue_swirl.png` | image | Зображення Blue Swirl Candy              |
| `candy_pink_swirl.png` | image | Зображення Pink Swirl Candy              |
| `candy_sky_blue.png`   | image | Зображення Sky Blue Candy                |
| `candy_green.png`      | image | Зображення Green Candy                   |
| `candy_purple.png`     | image | Зображення Purple Candy                  |
| `candy_cool.png`       | image | Зображення Cool Candy                    |
| `candy_turquoise.png`  | image | Зображення Turquoise Candy               |
| `candy_yellow.png`     | image | Зображення Yellow Candy                  |
| `candy_red.png`        | image | Зображення Red Candy                     |
| `candy_puple.png`      | image | Зображення Puple Candy                   |

---

### ⚙️ Логіка екрану

* **Кнопка назад (`btnBackSmall`)** → повертає на `Main Menu`.
* **Список інформаційних блоків (`infoItem`)**:

  * Відображаються вертикально в `SingleChildScrollView`.
  * Кожен має власне зображення, назву та опис.
  * Кастомний скрол — стилізований (scrollbar без системного вигляду).
* **Дані** можна зберігати як список у коді, без API-запитів.

---

### 🧱 Структура елементу `InfoItem`

| Назва поля    | Тип           | Опис                                                        |
| ------------- | ------------- | ----------------------------------------------------------- |
| `image`       | `Image.asset` | Зображення карамельки                                       |
| `title`       | `Text`        | Назва карамельки (великий текст, колір `#990071`)           |
| `description` | `Text`        | Короткий опис у два рядки, колір `#990071`, звичайний стиль |

---

### 📜 Контент (тексти для елементів)

| Назва                | Текст опису                                                                                                                     |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **BLUE SWIRL CANDY** | One interesting fact is that its ocean-like waves symbolize endless sweetness, making it feel like diving into a sea of sugar.  |
| **PINK SWIRL CANDY** | One interesting fact is that giant pink swirls were once carnival classics, crafted to look as fun as they taste.               |
| **SKY BLUE CANDY**   | One interesting fact is that blue sweets often trick your taste buds — many are raspberry-flavored, not blueberry.              |
| **GREEN CANDY**      | One interesting fact is that green candies are known for minty or lime vibes, refreshing and energizing with every bite.        |
| **PURPLE CANDY**     | One interesting fact is that spiral designs are made to catch the eye, promising endless fun and flavor.                        |
| **COOL CANDY**       | One interesting fact is that pink treats became popular because their playful color is linked with joy and celebration.         |
| **TURQUOISE CANDY**  | One interesting fact is that rare candy shades like turquoise were made to stand out, shining like hidden gems in a candy shop. |
| **YELLOW CANDY**     | One interesting fact is that yellow sweets add a zingy lemon kick, balancing sugar rush with tangy freshness.                   |
| **RED CANDY**        | One interesting fact is that red candies symbolize love and passion, often being the very first flavor to sell out.             |
| **PUPLE CANDY**      | One interesting fact is that purple candies often taste of berries, but their rich color has long been linked to royalty.       |

---

## 🔧 Екран: **Dialogue Screen**

### 🧩 Призначення

Цей екран служить вступною сценою гри — короткий діалог між двома персонажами перед початком ігрового процесу.
Він з’являється **тільки при першому запуску гри**, а після його проходження — при натисканні **Play** гра запускається одразу.

---

### 🖼️ Елементи UI

| Назва              | Тип                  | Опис                                                                  |
| ------------------ | -------------------- | --------------------------------------------------------------------- |
| `backgroundDialog0` | `Image.asset`        | Перше фонова сцена з дівчиною 1              |
| `backgroundDialog1` | `Image.asset`        | Друга фонова сцена з дівчиною 2|
| `dialogueBox`      | `Image.asset`        | Рамка з текстом діалогу.                                              |
| `dialogueText`     | `Text`               | Текст фрази поточного діалогу (шрифт Baloo, колір `#990071`).         |
| `btnNext`          | `ImageButton`        | Кнопка “вперед” (маленька кругла з іконкою).                          |
| `btnGoSmall`       | `Image.asset + Text` | Кнопка `GO` — завершує діалог і переходить у гру.                     |

---

### 📦 Ресурси

| Назва файлу            | Тип   | Призначення                                     |
| ---------------------- | ----- | ----------------------------------------------- |
| `background_dialog0.png` | image | Перша фонова сцена                              |
| `background_dialog1.png` | image | Друга фонова сцена                              |
| `dialogue_box.png`     | image | Рамка для тексту                                |
| `btn_next.png`   | image | Кнопка “вперед”                                 |
| `btn_small.png`     | image | Кнопка “GO” (окрема маленька кнопка)            |

---

### ⚙️ Логіка екрану

* **Діалоги відображаються послідовно** за натисканням кнопки `btnNext`.
* Кожна фраза змінює як текст, так і персонажа/фон (при потребі).
* Після останнього діалогу кнопка `btnNext` зникає, і з’являється кнопка `btnGoSmall`.
* Натискання `GO` запускає `GameScreen()` і встановлює прапорець `isDialogueCompleted = true` у `SharedPreferences`,
  щоб більше не показувати цей екран при наступних запусках.

---

### 💬 Текстові репліки діалогу

1️⃣ **Фон:** `background_dialog0.png`
**Текст:**

```
HELLO THERE!  
WHAT’S GOING ON IN THE CANDY?
```

2️⃣ **Фон:** `background_dialog1.png`
**Текст:**

```
THAT SOUNDS SERIOUS.  
I’LL DO WHAT I CAN TO DEAL WITH THE CANDY.
```

2️⃣ **Фон:** `background_dialog0.png`
**Текст:**

```
OH, THANK GOODNESS YOU’RE HERE! THERE’S A SOUR CANDY CAUSING CHAOS IN THE JAR. IT’S SCARING EVERYONE AND WE CAN’T ENJOY OUR SWEETNESS ANYMORE. PLEASE, CAN YOU HELP US?
```

3️⃣ **Фон:** `background_dialog1.png`
**Текст:**

```
THANK YOU SO MUCH!  
WE REALLY APPRECIATE IT!
```

→ Після цього з’являється кнопка **GO** для переходу до гри.

---

### 🔁 Поведінка після першого проходження

* При натисканні **Play** з головного меню:

  * Якщо `isDialogueCompleted == false` → відкривається `DialogueScreen`.
  * Якщо `isDialogueCompleted == true` → одразу запускається `GameScreen`.

---
✅ Прийняв. Нижче — детальний і повний **технічний опис екрану Game**, що охоплює усі стани гри: старт, геймплей, виграш, програш, оновлення рекорду.
Це основний ігровий екран, який працює на **Flame + Forge2D**, а обгортка UI — **Flutter**.

---

## 🎮 Екран: **Game Screen**

### 🧩 Призначення

Основний екран гри типу *Suika Game*, у якому користувач керує падінням карамельок різного розміру, комбінує їх у більші елементи й отримує очки.

---

### 🖼️ Елементи UI

| Назва                | Тип                   | Опис                                                         |
| -------------------- | --------------------- | ------------------------------------------------------------ |
| `backgroundGame`     | `Image.asset`         | Повноекранний фон                                            |
| `scorePanel`         | `Image.asset + Text`  | Рамка з поточним рахунком. Текст білий                       |
| `nextCandyPanel`     | `Image.asset + Icon`  | Картинка з іконкою наступної карамельки (з правого боку).    |
| `gameFrame`          | `Image.asset`         | Рамка ігрового поля.                                         |
| `tapHint`            | `Image.asset`         | Анімаційна підказка  картинка - “TAP TO ANY PLACE” і рука.   |
| `candiesBar`         | `Image.asset`         | Рамка внизу екрана з усіма видами candy у порядку зростання. |
| `candyIconsList`     | `Row` з `Image.asset` | Усі карамельки від найменшої до найбільшої, 10 видів.        |
| `topLimitLine`       | `CustomPaint`         | Лінія зверху поля, позначає межу допустимого рівня candy.    |
| `characterAnimation` | `Image.asset`         | Дівчина зліва, з’являється з анімацією при злитті candy.     |

---

### ⚙️ Логіка ігрового процесу

#### ▶️ Початок гри:

1. Показується `tapHint` картинка “TAP TO ANY PLACE”.
2. Після першого тапу на ігровому полі:

   * Підказка зникає.
   * Зверху поля відображається **Top Limit Line**.
   * Починається фізична симуляція.
   * З першого тапу з'являється candy найменшого рівня (`candy_puple`) і падає згори.

---

#### 🍬 Основна механіка (Suika-логіка)

*  `GameWidget` із фізикою Flame - співпадає з розміром екрану. В нас буде стек, буде йти фон,GameWidget а потім меню кнопки та інше. 
* **Кожен тап по полю** створює candy поточного типу (залежно від порядку). Наступну candy можна добавити тільки через 1с.
* Candy падає з позиції X, де користувач натиснув, **зверху ігрового поля**.
* `nextCandyPanel` - в нас буде тип або 1 або 2 candy.
* Якщо **дві однакові candy** стикаються:

  1. Вони зникають.
  2. На місці злиття створюється наступна candy за списком (`level + 1`).
  3. Розмір збільшується на **+10%**.
  4. Гравець отримує **score**, пропорційний рівню candy.
  5. Зліва коротко з’являється анімована **дівчина (characterAnimation)**, що показує на злиття, потім зникає.

---

#### ⚖️ Фізика (Flame + Forge2D)

* **Гравітація:** стандартна вниз (y: 10.0).
* **Стіни:** ліва, права та нижня межа — `BodyComponent` типу `static`.
* **Candy:** `CircleBodyComponent` з текстурою спрайта. Робимо одни клас який буде мати тільки один параметр - порядок candy. В нього будемо отримувати яка картинка та розмір.
* Коли candy торкаються одна одної — перевірка `collisionType`:

  * Якщо `sameType` → виконується merge-логіка.

---

#### 🏆 Умови завершення гри

##### **Виграш**

* Якщо створена **остання candy** (максимальний рівень):

  1. Ігровий процес зупиняється (`game.pauseEngine()`).
  2. Відображається **Win Dialogue** із бонусом.
  3. Зберігається результат у `SharedPreferences`.
  4. Оновлюється **Best Score** у головному меню якщо отримали більший результат.

##### **Програш**

* Якщо будь-яка candy перетинає **Top Limit Line**:

  1. Гра зупиняється.
  2. Згори падає **великий рожевий чупа-чупс (анімація)** у центр екрану.
  3. Відображається **Lose Dialogue** з кнопкою “RETRY”.
  4. Зберігається поточний score і оновлюється Best Score якщо отримали більший результат..

---

### 💬 Діалоги кінців гри

#### **Win Dialogue**

* **Елементи:**

  * Рамка з текстом:

    ```
    RECORD SCORE: 5000  
    YOUR BONUS: 2500 ⭐
    ```
  * Кнопка: `GET BONUS`
  * Кнопка закриття (іконка “Х”)
* **Дії:**
  `GET BONUS` → додає бонус до збережених балів, повертає в Main Menu.

#### **Lose Dialogue**

* **Елементи:**

  * Великий чупа-чупс із написом “YOU LOOSE!”
  * Кнопка `RETRY` (зображення `btn_retry.png`)
* **Дії:**
  `RETRY` → перезапуск гри з нуля (`game.reset()`).

---

### 📦 Ресурси

| Назва файлу                           | Тип   | Призначення                        |
| ------------------------------------- | ----- | ---------------------------------- |
| `background_game.png`                | image | Фонове зображення                  |
| `score_panel.png`                     | image | Рамка для рахунку                  |
| `next_candy_panel.png`                | image | Панель із іконкою наступного candy |
| `game_frame.png`                      | image | Основна рамка ігрового поля        |
| `candies_bar.png`                     | image | Рамка нижньої панелі               |
| `candy_puple.png` ... `candy_big.png` | image | Усі типи candy різних рівнів       |
| `tap_hint_hand.png`                   | image | Анімація руки                      |
| `top_line.png`                        | image | Лінія верхньої межі                |
| `character_left.png`                  | image | Дівчина зліва для анімації         |
| `chupachups_big.png`                  | image | Великий чупа-чупс для програшу     |
| `dialog_win.png`                      | image | Рамка діалогу виграшу              |
| `dialog_lose.png`                     | image | Рамка діалогу програшу             |
| `icon_star.png`                       | image | Іконка бонусу                      |

---

### 💾 Збереження даних (`SharedPreferences`)

* `best_score`: int — найкращий результат.
* `isDialogueCompleted`: bool — чи показувати вступний діалог.

---

### ⚙️ Потік станів екрана

1. **LoadingCandyGame** → показ підказки.
2. **Playing** → активна фізика, підрахунок очок.
3. **Merging** → анімація злиття та дівчини.
4. **WinState** → діалог виграшу.
5. **LoseState** → чупа-чупс + діалог програшу.

---

