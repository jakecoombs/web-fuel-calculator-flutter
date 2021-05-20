import "package:i18n_extension/i18n_extension.dart";

extension Localization on String {
  String get i18n => localize(this, t);
  static var t = Translations("en_gb") +
      {
        "en_gb": "Calculate",
        "en_us": "Calculate",
        "es": "Calcular",
        "pt_br": "Calcular",
        "de": "Berechnen",
        "nl": "Bereken",
        "it": "Calcola",
        "pl": "Oblicz",
        "fr": "Calculer",
        "no": "Beregn",
        "ru": "Вычислить",
        "zh": "计算",
      } +
      {
        "en_gb": "Save",
        "en_us": "Save",
        "es": "Guardar",
        "pt_br": "Salvar",
        "de": "Speichern",
        "nl": "Opslaan",
        "it": "Salva",
        "no": "Lagre",
        "pl": "Zapisz",
        "ru": "Сохранить",
        "zh": "储存",
        "fr": "Sauvegarder"
      } +
      {
        "en_gb": "Saved",
        "en_us": "Saved",
        "es": "Guardardo",
        "pt_br": "Salvo",
        "de": "Gespeichert",
        "nl": "Opgeslagen",
        "it": "Salvato",
        "no": "Lagret",
        "pl": "Zapisane",
        "ru": "Сохранено",
        "zh": "已储存",
        "fr": "Sauvegardé"
      } +
      {
        "en_gb": "Error",
        "en_us": "Error",
        "es": "Error",
        "pt_br": "Erro",
        "de": "Fehler",
        "nl": "Fout",
        "it": "Errore",
        "no": "Feil",
        "pl": "Błąd",
        "ru": "Ошибка",
        "zh": "错误",
        "fr": "Erreur"
      } +
      {
        "en_gb": "Please fill in all values",
        "en_us": "Please fill in all values",
        "es": "Por favor, llene los datos",
        "pt_br": "Por favor, preencha todos os valores",
        "de": "Alle Felder müssen ausgefüllt sein",
        "nl": "Vul a.u.b alle waardes in",
        "it": "Prego compila tutti i dati",
        "no": "Vennligst fyll inn alle verdier",
        "pl": "Prosze wypelnic wszystkie pola",
        "ru": "Введите все значения",
        "zh": "请填写所有数据",
        "fr": "Veuillez saisir tous les champs"
      } +
      {
        "en_gb": "Suggestions",
        "en_us": "Suggestions",
        "es": "Sugerencias",
        "pt_br": "Seugestões",
        "de": "Vorschläge an den Entwickle",
        "nl": "Suggestie",
        "it": "Suggerimenti",
        "pl": "Sugestie",
        "no": "Forslag",
        "ru": "Предложения",
        "zh": "建议",
        "fr": "Suggestions"
      } +
      {
        "en_gb": "Settings",
        "en_us": "Settings",
        "es": "Configuraciones",
        "pt_br": "Opções",
        "de": "Einstellungen",
        "nl": "Settings",
        "it": "Impostazioni",
        "no": "Instillinger",
        "pl": "Opcje",
        "ru": "Настройки",
        "zh": "设置",
        "fr": "Paramètres"
      } +
      {
        "en_gb": "Lap Time",
        "en_us": "Lap Time",
        "es": "Tiempo de la vuelta",
        "pt_br": "Tempo de volta",
        "de": "Rundenzeit",
        "nl": "Rondetijd",
        "it": "Tempo sul giro",
        "no": "Rundetid",
        "pl": "Czas okrazenia",
        "ru": "Время круга",
        "zh": "圈速",
        "fr": "Temps au tour"
      } +
      {
        "en_gb": "Stint Length",
        "en_us": "Stint Length",
        "es": "Duración de la sesión",
        "pt_br": "Tempo de Corrida (Stint)",
        "de": "Fahrtzeit",
        "nl": "Lengte van de stint",
        "it": "Lunghezza stint",
        "no": "Stintlengde",
        "pl": "Dlugosc jazdy",
        "ru": "Длинна отрезка",
        "zh": "Stint长度",
        "fr": "Durée du relai"
      } +
      {
        "en_gb": "Litres Per Lap",
        "en_us": "Liters Per Lap",
        "es": "Litros por vuelta",
        "pt_br": "Litros por volta",
        "de": "Liter pro Runde",
        "nl": "Liters per ronde",
        "it": "Litri per giro",
        "no": "Liter per runde",
        "pl": "Litry na okrarzenie",
        "ru": "Литров на круг",
        "zh": "升/每圈",
        "fr": "Litres par tour"
      } +
      {
        "en_gb": "Risky",
        "en_us": "Risky",
        "es": "Combustible arriesgado",
        "pt_br": "Combustível (Mínimo)",
        "de": "Mindestmenge",
        "nl": "Minimale brandstof",
        "it": "Rischio carburante",
        "pl": "Ryzykowne paliwo",
        "no": "Risikabel",
        "ru": "Рискованное топливо",
        "zh": "风险油量",
        "fr": "Valeur agressive"
      } +
      {
        "en_gb": "Safe",
        "en_us": "Safe",
        "es": "Combustible seguro",
        "pt_br": "Combustivel (Seguro)",
        "de": "Mit Sicherheitsreserven",
        "nl": "Veilige brandstof",
        "it": "Livello di sicurezza",
        "pl": "Bespieczne",
        "no": "Sikker",
        "ru": "Безопасное топливо",
        "zh": "安全油量",
        "fr": "Valeur sûre"
      } +
      {
        "en_gb": "Formation Lap",
        "en_us": "Formation Lap",
        "es": "Vuelta de formación",
        "pt_br": "Volta de apresentação",
        "de": "Einführungsrunde",
        "nl": "Formatie ronde",
        "it": "Giro di ricognizione",
        "no": "Formasjonsrunde",
        "pl": "Okrarzenie formujace",
        "ru": "Круг прогрева",
        "zh": "暖胎圈",
        "fr": "Tour de chauffe"
      } +
      {
        "en_gb": "Simple",
        "en_us": "Simple",
        "es": "Simple",
        "pt_br": "Simples",
        "de": "Einfach",
        "nl": "Simpel",
        "it": "Esemplio",
        "no": "Enkel",
        "pl": "Prosty",
        "ru": "Просто",
        "zh": "简易版",
        "fr": "Simple"
      } +
      {
        "en_gb": "Language",
        "en_us": "Language",
        "es": "Idioma",
        "pt_br": "Idioma",
        "de": "Sprache",
        "nl": "Taal",
        "it": "Lingua",
        "no": "Språk",
        "pl": "Jezyk",
        "ru": "Язык",
        "zh": "语言",
        "fr": "Langage"
      } +
      {
        "en_gb": "Upgrade To Premium",
        "en_us": "Upgrade To Premium",
        "es": "Conseguir la versión pagada",
        "pt_br": "Obtenha a versão premium",
        "de": "Upgrade auf Premium",
        "nl": "Ga voor premium",
        "it": "Passa a premium",
        "no": "Oppgrader til premium",
        "pl": "Uaktualnij do premium",
        "ru": "Перейти на премиум",
        "zh": "升级至高级版",
        "fr": "Mettre à niveau Premium"
      } +
      {
        "en_gb": "Premium Version",
        "en_us": "Premium Version",
        "es": "Versión pagada",
        "pt_br": "versão premium",
        "de": "Premium",
        "nl": "Premium versie",
        "it": "Versione premium",
        "no": "Premiumversjon",
        "pl": "Wersja premium",
        "ru": "Премиум версия",
        "fr": "Version Premium"
      } +
      {
        "en_gb": "Theme Settings",
        "en_us": "Theme Settings",
        "es": "Configuración del tema",
        "pt_br": "Opções de tema",
        "de": "Darstellungsoptionen",
        "nl": "Thema setting",
        "it": "Impostazione tema",
        "no": "Tema instillinger",
        "pl": "Ustawienia motywu",
        "ru": "Настройки темы",
        "zh": "主题设置",
        "fr": "Thème"
      } +
      {
        "en_gb": "Dark Mode",
        "en_us": "Dark Mode",
        "es": "Cambiar a modo oscuro",
        "pt_br": "Alterar para modo escuro",
        "de": "Dark Mode ein/aus",
        "nl": "Zet donkere mode aan",
        "it": "Passa allo sfondo nero",
        "no": "Mørk modus",
        "pl": "Ciemny motyw",
        "ru": "Тёмная тема",
        "zh": "深色模式",
        "fr": "Affichage sombre"
      } +
      {
        "en_gb": "Use system default theme",
        "en_us": "Use system default theme",
        "es": "Usar tema predeterminado del sistema",
        "pt_br": "Usar tema padrão do sistema",
        "de": "Standarddarstellung verwenden",
        "nl": "Gebruik standaard thema",
        "it": "Usa il tema prestabilito",
        "no": "Bruk standard systemtema",
        "pl": "Domyslny motyw",
        "ru": "Использовать стандартную тему устройства",
        "zh": "使用系统默认主题",
        "fr": "Utiliser le thème système"
      } +
      {
        "en_gb": "Fuel Calculator",
        "en_us": "Fuel Calculator",
        "es": "Calculadora de combustible",
        "pt_br": "Calculadora de combustível",
        "de": "Verbrauchsrechner",
        "nl": "Fuel Calculator",
        "it": "Calcolo Carburante",
        "no": "Drivstoffkalkulator",
        "pl": "Oblicz paliwo",
        "ru": "Калькулятор топлива",
        "zh": "油量计算器",
        "fr": "Calcul du niveau d'essence"
      } +
      {
        "en_gb": "Send a suggestion",
        "en_us": "Send a suggestion",
        "es": "Enviar una sugerencia",
        "pt_br": "Envie uma sugestão",
        "de": "Senden Sie einen Vorschlag",
        "nl": "Stuur een suggestie",
        "it": "Suggerimenti e critiche",
        "no": "Send et forslag",
        "pl": "Wyslij sugestie",
        "ru": "Отправить предложение",
        "zh": "提供建议",
        "fr": "Suggérer une idée"
      } +
      {
        "en_gb": "Submit",
        "en_us": "Submit",
        "es": "Enviar",
        "pt_br": "Enviar",
        "de": "einreichen",
        "nl": "Enter",
        "it": "Invia",
        "no": "Send inn",
        "pl": "Zatwierdz",
        "ru": "Отправить",
        "zh": "提交",
        "fr": "Soumettre"
      } +
      {
        "en_gb": "Dry",
        "en_us": "Dry",
        "es": "Seco",
        "pt_br": "Seco",
        "de": "Trocken",
        "nl": "Droog",
        "it": "Asciutto",
        "no": "Tørr",
        "pl": "Suchy",
        "ru": "Сухо",
        "zh": "干地",
        "fr": "Sec"
      } +
      {
        "en_gb": "Wet",
        "en_us": "Wet",
        "es": "Mojado",
        "pt_br": "Molhado",
        "de": "Regen",
        "nl": "Nat",
        "it": "Bagnato",
        "no": "Våt",
        "pl": "Mokry",
        "ru": "Мокро",
        "zh": "湿地",
        "fr": "Humide"
      } +
      {"en_gb": "Sign in / Sign up", "en_us": "Sign in / Sign up"} +
      {"en_gb": "Sign out", "en_us": "Sign out"} +
      {"en_gb": "Sign up", "en_us": "Sign up"} +
      {"en_gb": "Change password", "en_us": "Change password"} +
      {"en_gb": "Account", "en_us": "Account"};
}
