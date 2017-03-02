Unit g_language;

Interface

Uses
  g_Basic, MAPDEF;

Type
  TStrings_Locale = (
    I_NOT_ACCESSIBLE,

    I_ARRAY_BOOL_FALSE,
    I_ARRAY_BOOL_TRUE,

    I_ARRAY_DIR_LEFT,
    I_ARRAY_DIR_RIGHT,
    I_ARRAY_DIR_SAME,
    I_ARRAY_DIR_REVERSED,

    I_ARRAY_DIRBTN_LEFT,
    I_ARRAY_DIRBTN_RIGHT,
    I_ARRAY_DIRBTN_UP,
    I_ARRAY_DIRBTN_DOWN,

    I_ARRAY_PANEL_WALL,
    I_ARRAY_PANEL_BACK,
    I_ARRAY_PANEL_FRONT,
    I_ARRAY_PANEL_DOOR_OPEN,
    I_ARRAY_PANEL_DOOR_CLOSE,
    I_ARRAY_PANEL_STAIR,
    I_ARRAY_PANEL_WATER,
    I_ARRAY_PANEL_ACID_1,
    I_ARRAY_PANEL_ACID_2,
    I_ARRAY_PANEL_LIFT_UP,
    I_ARRAY_PANEL_LIFT_DOWN,
    I_ARRAY_PANEL_LIFT_LEFT,
    I_ARRAY_PANEL_LIFT_RIGHT,
    I_ARRAY_PANEL_BLOCKMON,

    I_ARRAY_FX_NONE,
    I_ARRAY_FX_TELEPORT,
    I_ARRAY_FX_RESPAWN,
    I_ARRAY_FX_FIRE,

    I_ARRAY_ITEM_MEDKIT,
    I_ARRAY_ITEM_LARGE_MEDKIT,
    I_ARRAY_ITEM_BLACK_MEDKIT,
    I_ARRAY_ITEM_GREEN_ARMOR,
    I_ARRAY_ITEM_BLUE_ARMOR,
    I_ARRAY_ITEM_BLUE_SPHERE,
    I_ARRAY_ITEM_MEGASPHERE,
    I_ARRAY_ITEM_HAZ_SUIT,
    I_ARRAY_ITEM_OXYGEN,
    I_ARRAY_ITEM_INVULNERABILITY,
    I_ARRAY_ITEM_CHAINSAW,
    I_ARRAY_ITEM_SHOTGUN,
    I_ARRAY_ITEM_DB_SHOTGUN,
    I_ARRAY_ITEM_CHAINGUN,
    I_ARRAY_ITEM_ROCKET_LAUNCHER,
    I_ARRAY_ITEM_PLASMA_RIFLE,
    I_ARRAY_ITEM_BFG,
    I_ARRAY_ITEM_SUPER_MINIGUN,
    I_ARRAY_ITEM_CLIP,
    I_ARRAY_ITEM_AMMO_BOX,
    I_ARRAY_ITEM_4_SHELLS,
    I_ARRAY_ITEM_25_SHELLS,
    I_ARRAY_ITEM_1_ROCKET,
    I_ARRAY_ITEM_ROCKET_BOX,
    I_ARRAY_ITEM_CELL,
    I_ARRAY_ITEM_LARGE_CELL,
    I_ARRAY_ITEM_BACKPACK,
    I_ARRAY_ITEM_KEY_RED,
    I_ARRAY_ITEM_KEY_GREEN,
    I_ARRAY_ITEM_KEY_BLUE,
    I_ARRAY_ITEM_BOTTLE,
    I_ARRAY_ITEM_HELMET,
    I_ARRAY_ITEM_JETPACK,
    I_ARRAY_ITEM_INVIS,

    I_ARRAY_SHOT_PISTOL,
    I_ARRAY_SHOT_BULLET,
    I_ARRAY_SHOT_SHOTGUN,
    I_ARRAY_SHOT_SSG,
    I_ARRAY_SHOT_IMP,
    I_ARRAY_SHOT_PLASMA,
    I_ARRAY_SHOT_SPIDER,
    I_ARRAY_SHOT_CACO,
    I_ARRAY_SHOT_BARON,
    I_ARRAY_SHOT_MANCUB,
    I_ARRAY_SHOT_REV,
    I_ARRAY_SHOT_ROCKET,
    I_ARRAY_SHOT_BFG,
    I_ARRAY_SHOT_EXPL,
    I_ARRAY_SHOT_BFGEXPL,

    I_ARRAY_MON_DEMON,
    I_ARRAY_MON_IMP,
    I_ARRAY_MON_ZOMBIE,
    I_ARRAY_MON_SERGEANT,
    I_ARRAY_MON_CYBER,
    I_ARRAY_MON_CGUN,
    I_ARRAY_MON_HELL_BARON,
    I_ARRAY_MON_HELL_KNIGHT,
    I_ARRAY_MON_CACODEMON,
    I_ARRAY_MON_LOST_SOUL,
    I_ARRAY_MON_PAIN_ELEMENTAL,
    I_ARRAY_MON_MASTERMIND,
    I_ARRAY_MON_ARACHNATRON,
    I_ARRAY_MON_MANCUBUS,
    I_ARRAY_MON_REVENANT,
    I_ARRAY_MON_ARCHVILE,
    I_ARRAY_MON_FISH,
    I_ARRAY_MON_BARREL,
    I_ARRAY_MON_ROBOT,
    I_ARRAY_MON_PRIKOLIST,

    I_ARRAY_AREA_PLAYER_ONE,
    I_ARRAY_AREA_PLAYER_TWO,
    I_ARRAY_AREA_DM,
    I_ARRAY_AREA_FLAG_RED,
    I_ARRAY_AREA_FLAG_BLUE,
    I_ARRAY_AREA_FLAG_DOM,
    I_ARRAY_AREA_TEAM_RED,
    I_ARRAY_AREA_TEAM_BLUE,

    I_ARRAY_TR_EXIT,
    I_ARRAY_TR_TELEPORT,
    I_ARRAY_TR_DOOR_OPEN,
    I_ARRAY_TR_DOOR_CLOSE,
    I_ARRAY_TR_DOOR_SWITCH,
    I_ARRAY_TR_DOOR_5_SEC,
    I_ARRAY_TR_TRAP_CLOSE,
    I_ARRAY_TR_TRAP,
    I_ARRAY_TR_EXTEND,
    I_ARRAY_TR_SECRET,
    I_ARRAY_TR_LIFT_UP,
    I_ARRAY_TR_LIFT_DOWN,
    I_ARRAY_TR_LIFT_SWITCH,
    I_ARRAY_TR_TEXTURE,
    I_ARRAY_TR_ON,
    I_ARRAY_TR_OFF,
    I_ARRAY_TR_SWITCH,
    I_ARRAY_TR_SOUND,
    I_ARRAY_TR_SPAWN_MONSTER,
    I_ARRAY_TR_SPAWN_ITEM,
    I_ARRAY_TR_MUSIC,
    I_ARRAY_TR_PUSH,
    I_ARRAY_TR_SCORE,
    I_ARRAY_TR_MESSAGE,
    I_ARRAY_TR_DAMAGE,
    I_ARRAY_TR_HEALTH,
    I_ARRAY_TR_SHOT,
    I_ARRAY_TR_EFFECT,
    I_ARRAY_TR_SCRIPT,

    I_PROP_ID,
    I_PROP_X,
    I_PROP_Y,
    I_PROP_WIDTH,
    I_PROP_HEIGHT,
    I_PROP_PANEL_TYPE,
    I_PROP_PANEL_TEX,
    I_PROP_PANEL_ALPHA,
    I_PROP_PANEL_BLEND,
    I_PROP_DM_ONLY,
    I_PROP_ITEM_FALLS,
    I_PROP_DIRECTION,

    I_PROP_TR_TYPE,
    I_PROP_TR_ENABLED,
    I_PROP_TR_TEXTURE_PANEL,
    I_PROP_TR_ACTIVATION,
    I_PROP_TR_KEYS,
    I_PROP_TR_D2D,
    I_PROP_TR_SILENT,
    I_PROP_TR_COUNT,
    I_PROP_TR_INTERVAL,
    I_PROP_TR_HEALTH,
    I_PROP_TR_NEXT_MAP,
    I_PROP_TR_TELEPORT_TO,
    I_PROP_TR_TELEPORT_SILENT,
    I_PROP_TR_TELEPORT_DIR,
    I_PROP_TR_DOOR_PANEL,
    I_PROP_TR_TRAP_PANEL,
    I_PROP_TR_EX_AREA,
    I_PROP_TR_EX_DELAY,
    I_PROP_TR_EX_COUNT,
    I_PROP_TR_EX_MONSTER,
    I_PROP_TR_EX_RANDOM,
    I_PROP_TR_LIFT_PANEL,
    I_PROP_TR_TEXTURE_ONCE,
    I_PROP_TR_TEXTURE_ANIM_ONCE,
    I_PROP_TR_SOUND_NAME,
    I_PROP_TR_SOUND_VOLUME,
    I_PROP_TR_SOUND_PAN,
    I_PROP_TR_SOUND_COUNT,
    I_PROP_TR_SOUND_LOCAL,
    I_PROP_TR_SOUND_SWITCH,
    I_PROP_TR_FX_TYPE,
    I_PROP_TR_SPAWN_TO,
    I_PROP_TR_SPAWN_MAX,
    I_PROP_TR_SPAWN_DELAY,
    I_PROP_TR_MONSTER_TYPE,
    I_PROP_TR_MONSTER_ACTIVE,
    I_PROP_TR_MONSTER_BEHAVIOUR,
    I_PROP_TR_MONSTER_BEHAVIOUR_0,
    I_PROP_TR_MONSTER_BEHAVIOUR_1,
    I_PROP_TR_MONSTER_BEHAVIOUR_2,
    I_PROP_TR_MONSTER_BEHAVIOUR_3,
    I_PROP_TR_MONSTER_BEHAVIOUR_4,
    I_PROP_TR_MONSTER_BEHAVIOUR_5,
    I_PROP_TR_ITEM_TYPE,
    I_PROP_TR_MUSIC_NAME,
    I_PROP_TR_MUSIC_ACT,
    I_PROP_TR_MUSIC_ON,
    I_PROP_TR_MUSIC_OFF,
    I_PROP_TR_PUSH_ANGLE,
    I_PROP_TR_PUSH_FORCE,
    I_PROP_TR_PUSH_RESET,
    I_PROP_TR_SCORE_ACT,
    I_PROP_TR_SCORE_ACT_0,
    I_PROP_TR_SCORE_ACT_1,
    I_PROP_TR_SCORE_ACT_2,
    I_PROP_TR_SCORE_ACT_3,
    I_PROP_TR_SCORE_TEAM,
    I_PROP_TR_SCORE_TEAM_0,
    I_PROP_TR_SCORE_TEAM_1,
    I_PROP_TR_SCORE_TEAM_2,
    I_PROP_TR_SCORE_TEAM_3,
    I_PROP_TR_SCORE_CON,
    I_PROP_TR_SCORE_MSG,
    I_PROP_TR_DAMAGE_VALUE,
    I_PROP_TR_HEALTH_MAX,
    I_PROP_TR_SHOT_TYPE,
    I_PROP_TR_SHOT_SOUND,
    I_PROP_TR_SHOT_ANGLE,
    I_PROP_TR_SHOT_ACC,
    I_PROP_TR_SHOT_TO,
    I_PROP_TR_SHOT_TO_0,
    I_PROP_TR_SHOT_TO_1,
    I_PROP_TR_SHOT_TO_2,
    I_PROP_TR_SHOT_TO_3,
    I_PROP_TR_SHOT_TO_4,
    I_PROP_TR_SHOT_TO_5,
    I_PROP_TR_SHOT_TO_6,
    I_PROP_TR_SHOT_AIM,
    I_PROP_TR_SHOT_AIM_0,
    I_PROP_TR_SHOT_AIM_1,
    I_PROP_TR_SHOT_AIM_2,
    I_PROP_TR_SHOT_AIM_3,
    I_PROP_TR_SHOT_AMMO,
    I_PROP_TR_SHOT_RELOAD,
    I_PROP_TR_SHOT_SIGHT,
    I_PROP_TR_SHOT_PANEL,
    I_PROP_TR_MESSAGE_KIND,
    I_PROP_TR_MESSAGE_KIND_0,
    I_PROP_TR_MESSAGE_KIND_1,
    I_PROP_TR_MESSAGE_TO,
    I_PROP_TR_MESSAGE_TO_0,
    I_PROP_TR_MESSAGE_TO_1,
    I_PROP_TR_MESSAGE_TO_2,
    I_PROP_TR_MESSAGE_TO_3,
    I_PROP_TR_MESSAGE_TO_4,
    I_PROP_TR_MESSAGE_TO_5,
    I_PROP_TR_MESSAGE_TEXT,
    I_PROP_TR_MESSAGE_TIME,
    I_PROP_TR_EFFECT_TYPE,
    I_PROP_TR_EFFECT_SUBTYPE,
    I_PROP_TR_EFFECT_COLOR,
    I_PROP_TR_EFFECT_CENTER,
    I_PROP_TR_EFFECT_VELX,
    I_PROP_TR_EFFECT_VELY,
    I_PROP_TR_EFFECT_SPL,
    I_PROP_TR_EFFECT_SPR,
    I_PROP_TR_EFFECT_SPU,
    I_PROP_TR_EFFECT_SPD,
    I_PROP_TR_EFFECT_PARTICLE,
    I_PROP_TR_EFFECT_ANIMATION,
    I_PROP_TR_EFFECT_SLIQUID,
    I_PROP_TR_EFFECT_LLIQUID,
    I_PROP_TR_EFFECT_DLIQUID,
    I_PROP_TR_EFFECT_BLOOD,
    I_PROP_TR_EFFECT_SPARK,
    I_PROP_TR_EFFECT_BUBBLE,
    I_PROP_TR_SCRIPT_PROC,
    I_PROP_TR_SCRIPT_ARG,

    I_MSG_ERROR,
    I_MSG_WRONG_TEXWIDTH,
    I_MSG_WRONG_TEXHEIGHT,
    I_MSG_WRONG_ALPHA,
    I_MSG_WRONG_SIZE,
    I_MSG_WRONG_XY,
    I_MSG_TEXTURE_ALREADY,
    I_MSG_RES_NAME_64,
    I_MSG_CHOOSE_ITEM,
    I_MSG_CHOOSE_MONSTER,
    I_MSG_CHOOSE_AREA,
    I_MSG_CHOOSE_TEXTURE,
    I_MSG_CHOOSE_RES,
    I_MSG_EXIT,
    I_MSG_EXIT_PROMT,
    I_MSG_DEL_TEXTURE,
    I_MSG_DEL_TEXTURE_PROMT,
    I_MSG_DEL_TEXTURE_CANT,
    I_MSG_CLEAR_MAP,
    I_MSG_CLEAR_MAP_PROMT,
    I_MSG_DELETE_MAP,
    I_MSG_DELETE_MAP_PROMT,
    I_MSG_MAP_DELETED,
    I_MSG_MAP_DELETED_PROMT,
    I_MSG_EXEC_ERROR,
    I_MSG_SOUND_ERROR,
    I_MSG_WAD_ERROR,
    I_MSG_RES_ERROR,
    I_MSG_PACKED,
    I_MSG_MAP_EXISTS,
    I_MSG_SAVE_MAP,

    I_HINT_TELEPORT,
    I_HINT_SPAWN,
    I_HINT_PANEL_DOOR,
    I_HINT_PANEL_TEXTURE,
    I_HINT_PANEL_SHOT,
    I_HINT_PANEL_LIFT,
    I_HINT_MONSTER,
    I_HINT_EXT_AREA,
    I_HINT_WIDTH,
    I_HINT_HEIGHT,

    I_MENU_FILE,
    I_MENU_FILE_NEW,
    I_MENU_FILE_OPEN,
    I_MENU_FILE_SAVE,
    I_MENU_FILE_SAVE_AS,
    I_MENU_FILE_OPEN_WAD,
    I_MENU_FILE_SAVE_MINI,
    I_MENU_FILE_DELETE,
    I_MENU_FILE_PACK_MAP,
    I_MENU_FILE_EXIT,

    I_MENU_EDIT,
    I_MENU_EDIT_UNDO,
    I_MENU_EDIT_COPY,
    I_MENU_EDIT_CUT,
    I_MENU_EDIT_PASTE,
    I_MENU_EDIT_SELECT_ALL,
    I_MENU_EDIT_TO_FORE,
    I_MENU_EDIT_TO_BACK,

    I_MENU_TOOLS,
    I_MENU_TOOLS_SNAP_GRID,
    I_MENU_TOOLS_MINIMAP,
    I_MENU_TOOLS_STEP_GRID,
    I_MENU_TOOLS_SHOW_EDGES,
    I_MENU_TOOLS_LAYERS,

    I_MENU_SERV,
    I_MENU_SERV_TEST,
    I_MENU_SERV_OPT,
    I_MENU_SERV_PREVIEW,
    I_MENU_SERV_LAUNCH,

    I_MENU_SETS,
    I_MENU_SETS_MAP,
    I_MENU_SETS_EDITOR,
    I_MENU_SETS_LAUNCH,

    I_MENU_HELP,
    I_MENU_HELP_ABOUT,

    I_MENU_LAYER_BACK,
    I_MENU_LAYER_WALL,
    I_MENU_LAYER_FORE,
    I_MENU_LAYER_STAIR,
    I_MENU_LAYER_WATER,
    I_MENU_LAYER_ITEM,
    I_MENU_LAYER_MONSTER,
    I_MENU_LAYER_AREA,
    I_MENU_LAYER_TRIGGER,

    I_MENU_TB_NEW,
    I_MENU_TB_OPEN,
    I_MENU_TB_SAVE,
    I_MENU_TB_OPEN_WAD,
    I_MENU_TB_MINIMAP,
    I_MENU_TB_LAYERS,
    I_MENU_TB_GRID,
    I_MENU_TB_GRID_STEP,
    I_MENU_TB_LAUNCH,

    I_MENU_LAUNCH_SETS,

    I_CAP_FX_TYPE,
    I_CAP_MONSTER_TYPE,
    I_CAP_ITEM_TYPE,
    I_CAP_ABOUT,
    I_CAP_ACT,
    I_CAP_ADD_SKY,
    I_CAP_ADD_SOUND,
    I_CAP_ADD_TEXTURE,
    I_CAP_KEYS,
    I_CAP_TEST,
    I_CAP_OPT,
    I_CAP_SETS,
    I_CAP_LAUNCH,
    I_CAP_ES,
    I_CAP_PACK,
    I_CAP_SAVE,
    I_CAP_MINI,
    I_CAP_SELECT,
    
    I_CTRL_PROP_KEY,
    I_CTRL_PROP_VALUE,
    I_CTRL_PANELS,
    I_CTRL_ITEMS,
    I_CTRL_MONSTERS,
    I_CTRL_AREAS,
    I_CTRL_TRIGGERS,

    I_CTRL_LIST_TEXTURE,
    I_CTRL_LIST_ITEM,
    I_CTRL_LIST_MONSTER,
    I_CTRL_LIST_AREA,
    I_CTRL_LIST_TRIGGER,
    I_CTRL_LIST_ACTIVE,
    I_CTRL_LIST_KEYS,

    I_CTRL_PREVIEW,
    I_CTRL_ITEM_DM,
    I_CTRL_ITEM_FALLS,
    I_CTRL_LEFT,
    I_CTRL_RIGHT,

    I_CTRL_ACT_PLAYER_CLOSE,
    I_CTRL_ACT_MONSTER_CLOSE,
    I_CTRL_ACT_PLAYER_PRESS,
    I_CTRL_ACT_MONSTER_PRESS,
    I_CTRL_ACT_SHOT,
    I_CTRL_ACT_NO_MONSTER,

    I_CTRL_KEYS_RED,
    I_CTRL_KEYS_GREEN,
    I_CTRL_KEYS_BLUE,
    I_CTRL_KEYS_TEAM_RED,
    I_CTRL_KEYS_TEAM_BLUE,
    
    I_CTRL_OPT_GB,
    I_CTRL_OPT_TEXTURE,
    I_CTRL_OPT_PANEL,
    I_CTRL_OPT_WALL,
    I_CTRL_OPT_FORE,
    I_CTRL_OPT_BACK,
    I_CTRL_OPT_STAIR,
    I_CTRL_OPT_WATER,
    I_CTRL_OPT_ACID1,
    I_CTRL_OPT_ACID2,
    I_CTRL_OPT_LIFT,
    I_CTRL_OPT_BLOCKMON,
    I_CTRL_OPT_DESC_TEXTURE,
    I_CTRL_OPT_DESC_PANEL,

    I_CTRL_SETS_STATS,
    I_CTRL_SETS_SIZES,

    I_CTRL_LAUNCH_DM,
    I_CTRL_LAUNCH_TDM,
    I_CTRL_LAUNCH_CTF,
    I_CTRL_LAUNCH_COOP,
    I_CTRL_LAUNCH_2P,
    I_CTRL_LAUNCH_FF,
    I_CTRL_LAUNCH_EXIT,
    I_CTRL_LAUNCH_WEAPONS,
    I_CTRL_LAUNCH_MONSTERS,
    I_CTRL_LAUNCH_CLOSE,
    I_CTRL_LAUNCH_OPEN,

    I_CTRL_ES_GRID,
    I_CTRL_ES_TEXTURE,
    I_CTRL_ES_PANEL_SIZE,

    I_CTRL_PACK_TEXTURES,
    I_CTRL_PACK_SKY,
    I_CTRL_PACK_MUSIC,
    I_CTRL_PACK_ADD,
    I_CTRL_PACK_NON_STD,

    I_LAB_TEX_WIDTH,
    I_LAB_TEX_HEIGHT,

    I_LAB_SPECTRUM,

    I_LAB_ABOUT_VER,
    I_LAB_ABOUT_AUTHOR,
    I_LAB_ABOUT_AUTHOR_2,
    I_LAB_ABOUT_MAIL,
    I_LAB_ABOUT_MAIL_2,
    I_LAB_ABOUT_SITE,
    I_LAB_ABOUT_HTTP,

    I_LAB_ADD_WADS,
    I_LAB_ADD_SECTIONS,

    I_LAB_SETS_NAME,
    I_LAB_SETS_DESC,
    I_LAB_SETS_AUTHOR,
    I_LAB_SETS_BACK,
    I_LAB_SETS_MUSIC,
    I_LAB_SETS_TEXTURES,
    I_LAB_SETS_PANELS,
    I_LAB_SETS_ITEMS,
    I_LAB_SETS_MONSTERS,
    I_LAB_SETS_AREAS,
    I_LAB_SETS_TRIGGERS,
    I_LAB_SETS_SIZES,
    I_LAB_SETS_WIDTH,
    I_LAB_SETS_HEIGHT,
    I_LAB_SETS_MAPMOVE,
    I_LAB_SETS_SNAPPING,

    I_LAB_LAUNCH_TIME,
    I_LAB_LAUNCH_SECS,
    I_LAB_LAUNCH_SCORE,
    I_LAB_LAUNCH_PATH,

    I_LAB_ES_GRID,
    I_LAB_ES_GRID_COLOR,
    I_LAB_ES_BACK,
    I_LAB_ES_PREVIEW,
    I_LAB_ES_MINIMAP,
    I_LAB_ES_RECENT,
    I_LAB_ES_LANGUAGE,

    I_LAB_PACK_SAVE_TO,
    I_LAB_PACK_MAP_NAME,
    I_LAB_PACK_TEXTURES,
    I_LAB_PACK_SKY,
    I_LAB_PACK_MUSIC,

    I_LAB_MINI_SCALE,
    
    I_BTN_APPLY_PROPS,
    I_BTN_OK,
    I_BTN_CANCEL,
    I_BTN_ADD,
    I_BTN_CLOSE,
    I_BTN_ADD_CLOSE,
    I_BTN_TEST_AGAIN,
    I_BTN_START,
    I_BTN_PACK,
    I_BTN_SAVE,
    I_BTN_NO_SOUND,
    I_BTN_TEXTURE_ADD,
    I_BTN_TEXTURE_DELETE,
    I_BTN_TEXTURE_EMPTY,

    I_LOAD_WAD,
    I_LOAD_MAP,
    I_LOAD_TEXTURES,
    I_LOAD_PANELS,
    I_LOAD_ITEMS,
    I_LOAD_MONSTERS,
    I_LOAD_AREAS,
    I_LOAD_TRIGGERS,

    I_TEST_AREA_WALL,
    I_TEST_AREA_WALL_STR,
    I_TEST_SPAWNS_1,
    I_TEST_SPAWNS_2,
    I_TEST_SPAWNS,
    I_TEST_NO_DM,
    I_TEST_NO_DM_EX,
    I_TEST_MONSTER_WALL,
    I_TEST_MONSTER_WALL_STR,

    I_OPT_NO_TEXTURES,
    I_OPT_DELETED_TEXTURES,
    I_OPT_TOTAL_TEXTURES,
    I_OPT_TEX_DELETED,
    I_OPT_PANELS_OPT,
    I_OPT_WALLS,
    I_OPT_FORES,
    I_OPT_BACKS,
    I_OPT_STAIRS,
    I_OPT_WATER,
    I_OPT_ACID1,
    I_OPT_ACID2,
    I_OPT_LIFTS,
    I_OPT_BLOCKMON,
    I_OPT_TOTAL_PANELS,
    I_OPT_PANELS_AFTER,

    I_WAD_SPECIAL_MAP,
    I_WAD_SPECIAL_TEXS,

    I_FILE_FILTER_ALL,
    I_FILE_FILTER_WAD,

    I_EDITOR_TITLE,
    
    I_LAST );

Const
  LANGUAGE_RUSSIAN = 'Russian';
  LANGUAGE_ENGLISH = 'English';
  LANGUAGE_RUSSIAN_N = 3;
  LANGUAGE_ENGLISH_N = 2;

Var
  _lc: Array [TStrings_Locale] of String;

  BoolNames: Array [False..True] of String;
  DirNames: Array [D_LEFT..D_RIGHT] of String;
  DirNamesAdv: Array [0..3] of String;
  DirButtonNames: Array [1..4] of String;
  PANELNAMES: Array[0..13] of String;
  EffectNames: Array [EFFECT_NONE..EFFECT_FIRE] of String;
  ItemNames: Array [ITEM_MEDKIT_SMALL..ITEM_MAX] of String;
  ShotNames: Array [TRIGGER_SHOT_PISTOL..TRIGGER_SHOT_MAX] of String;
  MonsterNames: Array [MONSTER_DEMON..MONSTER_MAN] of String;
  AreaNames: Array [AREA_PLAYERPOINT1..AREA_BLUETEAMPOINT] of String;
  TriggerNames: Array [TRIGGER_EXIT..TRIGGER_MAX] of String;


procedure g_Language_Load(fileName: String);
procedure g_Language_Set(lang: String);
procedure g_Language_Dump(fileName: String);

Implementation

Uses
  SysUtils, e_log, f_main, f_about, f_activationtype,
  f_addresource_sky, f_addresource_sound,
  f_addresource_texture, f_choosetype, f_keys, f_mapcheck,
  f_mapoptions, f_maptest, f_mapoptimization, f_options,
  f_packmap, f_savemap, f_saveminimap, f_selectmap, Forms;

Const
  g_lang_default: Array [TStrings_Locale] of Array [1..3] of String = (
    ('NOT ACCESSIBLE',                 'N/A',
                                       '�/�'),

    ('ARRAY BOOL FALSE',               'No',
                                       '���'),
    ('ARRAY BOOL TRUE',                'Yes',
                                       '��'),

    ('ARRAY DIR LEFT',                 'Left',
                                       '�����'),
    ('ARRAY DIR RIGHT',                'Right',
                                       '������'),
    ('ARRAY DIR SAME',                 'Don''t change',
                                       '�� ������'),
    ('ARRAY DIR REVERSED',             'Reversed',
                                       '��������'),

    ('ARRAY DIRBTN LEFT',              'Left',
                                       '�����'),
    ('ARRAY DIRBTN RIGHT',             'Right',
                                       '������'),
    ('ARRAY DIRBTN UP',                'Up',
                                       '�����'),
    ('ARRAY DIRBTN DOWN',              'Down',
                                       '����'),

    ('ARRAY PANEL WALL',               'Wall',
                                       '�����'),
    ('ARRAY PANEL BACK',               'Background',
                                       '���'),
    ('ARRAY PANEL FRONT',              'Foreground',
                                       '�������� ����'),
    ('ARRAY PANEL DOOR OPEN',          'Open Door',
                                       '�������� �����'),
    ('ARRAY PANEL DOOR CLOSE',         'Closed Door',
                                       '�������� �����'),
    ('ARRAY PANEL STAIR',              'Step',
                                       '�������'),
    ('ARRAY PANEL WATER',              'Water',
                                       '����'),
    ('ARRAY PANEL ACID 1',             'Acid 1',
                                       '������� 1'),
    ('ARRAY PANEL ACID 2',             'Acid 2',
                                       '������� 2'),
    ('ARRAY PANEL LIFT UP',            'Stream Up',
                                       '���� �����'),
    ('ARRAY PANEL LIFT DOWN',          'Stream Down',
                                       '���� ����'),
    ('ARRAY PANEL LIFT LEFT',          'Stream Left',
                                       '����� �����'),
    ('ARRAY PANEL LIFT RIGHT',         'Stream Right',
                                       '����� ������'),
    ('ARRAY PANEL BLOCKMON',           'Monster Boundary',
                                       '���������� ��������'),

    ('ARRAY FX NONE',                  'None',
                                       '���'),
    ('ARRAY FX TELEPORT',              'Teleport',
                                       '������������'),
    ('ARRAY FX RESPAWN',               'Respawn',
                                       '�������'),
    ('ARRAY FX FIRE',                  'Arch-Vile Fire',
                                       '����� �������'),

    ('ARRAY ITEM MEDKIT',              'Stimpack',
                                       '�������'),
    ('ARRAY ITEM LARGE MEDKIT',        'Medikit',
                                       '������� �������'),
    ('ARRAY ITEM BLACK MEDKIT',        'Berserk Pack',
                                       '������ �������'),
    ('ARRAY ITEM GREEN ARMOR',         'Green Armor',
                                       '������ �����'),
    ('ARRAY ITEM BLUE ARMOR',          'Blue Armor',
                                       '����� �����'),
    ('ARRAY ITEM BLUE SPHERE',         'Soulsphere',
                                       '����� 100%'),
    ('ARRAY ITEM MEGASPHERE',          'Megasphere',
                                       '���������'),
    ('ARRAY ITEM HAZ SUIT',            'Envirosuit',
                                       '�������� ������'),
    ('ARRAY ITEM OXYGEN',              'Scuba',
                                       '��������'),
    ('ARRAY ITEM INVULNERABILITY',     'Invulnerability',
                                       '������������'),
    ('ARRAY ITEM CHAINSAW',            'Chainsaw',
                                       '���������'),
    ('ARRAY ITEM SHOTGUN',             'Shotgun',
                                       '�����'),
    ('ARRAY ITEM DB SHOTGUN',          'Super Shotgun',
                                       '����������'),
    ('ARRAY ITEM CHAINGUN',            'Chaingun',
                                       '������'),
    ('ARRAY ITEM ROCKET LAUNCHER',     'Rocket Launcher',
                                       '���������'),
    ('ARRAY ITEM PLASMA RIFLE',        'Plasma Rifle',
                                       '���������'),
    ('ARRAY ITEM BFG',                 'BFG9000',
                                       'BFG9000'),
    ('ARRAY ITEM SUPER MINIGUN',       'Super Chaingun',
                                       '�����������'),
    ('ARRAY ITEM CLIP',                'Clip',
                                       '�������'),
    ('ARRAY ITEM AMMO BOX',            'Box of Bullets',
                                       '���� ��������'),
    ('ARRAY ITEM 4 SHELLS',            '4 Shells',
                                       '4 ������'),
    ('ARRAY ITEM 25 SHELLS',           'Box of Shells',
                                       '25 �����'),
    ('ARRAY ITEM 1 ROCKET',            'Rocket',
                                       '1 ������'),
    ('ARRAY ITEM ROCKET BOX',          'Box of Rockets',
                                       '5 �����'),
    ('ARRAY ITEM CELL',                'Energy Cell',
                                       '���������'),
    ('ARRAY ITEM LARGE CELL',          'Energy Cell Pack',
                                       '�������'),
    ('ARRAY ITEM BACKPACK',            'Backpack',
                                       '������'),
    ('ARRAY ITEM KEY RED',             'Red Key',
                                       '������� ����'),
    ('ARRAY ITEM KEY GREEN',           'Green Key',
                                       '������� ����'),
    ('ARRAY ITEM KEY BLUE',            'Blue Key',
                                       '����� ����'),
    ('ARRAY ITEM BOTTLE',              'Health Globe',
                                       '����� ����'),
    ('ARRAY ITEM HELMET',              'Armor Shard',
                                       '���������'),
    ('ARRAY ITEM JETPACK',             'Jetpack',
                                       '���������� �����'),
    ('ARRAY ITEM INVIS',               'Invisibility',
                                       '�����������'),

    ('ARRAY SHOT PISTOL',              'Pistol shot',
                                       '������� ���������'),
    ('ARRAY SHOT BULLET',              'Chaingun shot',
                                       '������� ��������'),
    ('ARRAY SHOT SHOTGUN',             'Shotgun shot',
                                       '������� �����'),
    ('ARRAY SHOT SSG',                 'Super Shotgun shot',
                                       '������� ����������'),
    ('ARRAY SHOT IMP',                 'Imp fireball',
                                       '��� ����'),
    ('ARRAY SHOT PLASMA',              'Blue plasma',
                                       '����� ������'),
    ('ARRAY SHOT SPIDER',              'Arachnotron plasma',
                                       '������ �����������'),
    ('ARRAY SHOT CACO',                'Cacodemon fireball',
                                       '��� ����������'),
    ('ARRAY SHOT BARON',               'Hell Baron projectile',
                                       '������� ������ ���'),
    ('ARRAY SHOT MANCUB',              'Mancubus gunshot',
                                       '������ ���������'),
    ('ARRAY SHOT REV',                 'Revenant projectile',
                                       '������ �������'),
    ('ARRAY SHOT ROCKET',              'Rocket',
                                       '������'),
    ('ARRAY SHOT BFG',                 'BFG ball',
                                       '��� BFG'),
    ('ARRAY SHOT EXPL',                'Explosion',
                                       '�����'),
    ('ARRAY SHOT BFGEXPL',             'BFG explosion',
                                       '����� BFG'),

    ('ARRAY MON DEMON',                'Pinky',
                                       '�����'),
    ('ARRAY MON IMP',                  'Imp',
                                       '���'),
    ('ARRAY MON ZOMBIE',               'Zombie',
                                       '�����'),
    ('ARRAY MON SERGEANT',             'Sergeant',
                                       '�������'),
    ('ARRAY MON CYBER',                'Cyberdemon',
                                       '����������'),
    ('ARRAY MON CGUN',                 'Commando',
                                       '���������'),
    ('ARRAY MON HELL BARON',           'Hell Baron',
                                       '����� ���'),
    ('ARRAY MON HELL KNIGHT',          'Hell Knight',
                                       '������ ���'),
    ('ARRAY MON CACODEMON',            'Cacodemon',
                                       '���������'),
    ('ARRAY MON LOST SOUL',            'Lost Soul',
                                       '�������� �����'),
    ('ARRAY MON PAIN ELEMENTAL',       'Pain Elemental',
                                       '��������'),
    ('ARRAY MON MASTERMIND',           'Spider Mastermind',
                                       '������� ����'),
    ('ARRAY MON ARACHNATRON',          'Arachnotron',
                                       '����������'),
    ('ARRAY MON MANCUBUS',             'Mancubus',
                                       '��������'),
    ('ARRAY MON REVENANT',             'Revenant',
                                       '������'),
    ('ARRAY MON ARCHVILE',             'Arch-Vile',
                                       '������'),
    ('ARRAY MON FISH',                 'Piranha',
                                       '����'),
    ('ARRAY MON BARREL',               'Barrel',
                                       '�����'),
    ('ARRAY MON ROBOT',                'Robot',
                                       '�����'),
    ('ARRAY MON PRIKOLIST',            'Prikolist',
                                       '���������'),

    ('ARRAY AREA PLAYER ONE',          'Player 1',
                                       '������ �����'),
    ('ARRAY AREA PLAYER TWO',          'Player 2',
                                       '������ �����'),
    ('ARRAY AREA DM',                  'DM Spawn Point',
                                       '����� DM'),
    ('ARRAY AREA FLAG RED',            'Red Flag',
                                       '������� ����'),
    ('ARRAY AREA FLAG BLUE',           'Blue Flag',
                                       '����� ����'),
    ('ARRAY AREA FLAG DOM',            'Domination Flag',
                                       'DOM ����'),
    ('ARRAY AREA TEAM RED',            'Red Team',
                                       '������� �������'),
    ('ARRAY AREA TEAM BLUE',           'Blue Team',
                                       '����� �������'),

    ('ARRAY TR EXIT',                  'Exit',
                                       '�����'),
    ('ARRAY TR TELEPORT',              'Teleport',
                                       '������������'),
    ('ARRAY TR DOOR OPEN',             'Open Door',
                                       '������� �����'),
    ('ARRAY TR DOOR CLOSE',            'Close Door',
                                       '������� �����'),
    ('ARRAY TR DOOR SWITCH',           'Door',
                                       '�����'),
    ('ARRAY TR DOOR 5 SEC',            'Door (5 sec)',
                                       '����� (5 ������)'),
    ('ARRAY TR TRAP CLOSE',            'Close Trap',
                                       '������� �������'),
    ('ARRAY TR TRAP',                  'Trap',
                                       '�������'),
    ('ARRAY TR EXTEND',                'Extender',
                                       '�����������'),
    ('ARRAY TR SECRET',                'Secret',
                                       '������'),
    ('ARRAY TR LIFT UP',               'Turn stream up/left',
                                       '���� �����/����� �����'),
    ('ARRAY TR LIFT DOWN',             'Turn stream down/right',
                                       '���� ����/����� ������'),
    ('ARRAY TR LIFT SWITCH',           'Revert stream',
                                       '����'),
    ('ARRAY TR TEXTURE',               'Change Texture',
                                       '����� ��������'),
    ('ARRAY TR ON',                    'Enable Trigger',
                                       '�������� �������'),
    ('ARRAY TR OFF',                   'Disable Trigger',
                                       '��������� �������'),
    ('ARRAY TR SWITCH',                'Trigger Toggle',
                                       '����������� �������'),
    ('ARRAY TR SOUND',                 'Play Sound',
                                       '����'),
    ('ARRAY TR SPAWN MONSTER',         'Spawn Monster',
                                       '������� �������'),
    ('ARRAY TR SPAWN ITEM',            'Spawn Item',
                                       '������� �������'),
    ('ARRAY TR MUSIC',                 'Play Music',
                                       '������'),
    ('ARRAY TR PUSH',                  'Push',
                                       '���������'),
    ('ARRAY TR SCORE',                 'Team Score',
                                       '���������� �����'),
    ('ARRAY TR MESSAGE',               'Message',
                                       '���������'),
    ('ARRAY TR DAMAGE',                'Damage',
                                       '����'),
    ('ARRAY TR HEALTH',                'Healer',
                                       '������������'),
    ('ARRAY TR SHOT',                  'Turret',
                                       '������'),
    ('ARRAY TR EFFECT',                'Effect',
                                       '������'),
    ('ARRAY TR SCRIPT',                'Script',
                                       '������'),

    ('PROP ID',                        'ID',
                                       'ID'),
    ('PROP X',                         'X',
                                       'X'),
    ('PROP Y',                         'Y',
                                       'Y'),
    ('PROP WIDTH',                     'Width',
                                       '������'),
    ('PROP HEIGHT',                    'Height',
                                       '������'),
    ('PROP PANEL TYPE',                'Panel Type',
                                       '��� ������'),
    ('PROP PANEL TEX',                 'Texture',
                                       '��������'),
    ('PROP PANEL ALPHA',               'Transparency',
                                       '������������'),
    ('PROP PANEL BLEND',               'Blending',
                                       '����������'),
    ('PROP DM ONLY',                   'DM Only',
                                       '������ � DM'),
    ('PROP ITEM FALLS',                'Falls',
                                       '������'),
    ('PROP DIRECTION',                 'Direction',
                                       '�����������'),

    ('PROP TR TYPE',                   'Trigger Type',
                                       '��� ��������'),
    ('PROP TR ENABLED',                'Enabled',
                                       '�������'),
    ('PROP TR TEXTURE PANEL',          'Textured Panel',
                                       '������ � ���������'),
    ('PROP TR ACTIVATION',             'Activation Type',
                                       '��� ���������'),
    ('PROP TR KEYS',                   'Keys',
                                       '�����'),
    ('PROP TR D2D',                    'D2D-like',
                                       '��� � D2D'),
    ('PROP TR SILENT',                 'Silent',
                                       '��� �����'),
    ('PROP TR COUNT',                  'Count',
                                       '����������'),
    ('PROP TR INTERVAL',               'Interval (in ticks)',
                                       '�������� (� �����)'),
    ('PROP TR HEALTH',                 'Health',
                                       '��������'),
    ('PROP TR NEXT MAP',               'Next Map',
                                       '����. �����'),
    ('PROP TR TELEPORT TO',            'Teleport to',
                                       '����� ���������'),
    ('PROP TR TELEPORT SILENT',        'Silent',
                                       '����� ��������'),
    ('PROP TR TELEPORT DIR',           'New Direction',
                                       '����������� �����'),
    ('PROP TR DOOR PANEL',             'Door Panel',
                                       '������ �����'),
    ('PROP TR TRAP PANEL',             'Trap Panel',
                                       '������ �������'),
    ('PROP TR EX AREA',                'Action Area',
                                       '������� �����������'),
    ('PROP TR EX DELAY',               'Delay',
                                       '��������'),
    ('PROP TR EX COUNT',               'Count',
                                       '�������'),
    ('PROP TR EX MONSTER',             'Monster ID',
                                       'ID �������'),
    ('PROP TR EX RANDOM',              'Random',
                                       '���������'),
    ('PROP TR LIFT PANEL',             'Stream Panel',
                                       '������ �����'),
    ('PROP TR TEXTURE ONCE',           'Once',
                                       '���� ���'),
    ('PROP TR TEXTURE ANIM ONCE',      'Animate Once',
                                       '����. ���� ���'),
    ('PROP TR SOUND NAME',             'Sound                              (snd)',
                                       '����                               (snd)'),
    ('PROP TR SOUND VOLUME',           'Volume',
                                       '���������'),
    ('PROP TR SOUND PAN',              'Pan',
                                       '������'),
    ('PROP TR SOUND COUNT',            'Loops',
                                       '������ ���'),
    ('PROP TR SOUND LOCAL',            'Local',
                                       '���������'),
    ('PROP TR SOUND SWITCH',           'Switch',
                                       '������������'),
    ('PROP TR FX TYPE',                'Effect',
                                       '������'),
    ('PROP TR SPAWN TO',               'Spawn at',
                                       '����� ���������'),
    ('PROP TR SPAWN MAX',              'Maximum',
                                       '��������'),
    ('PROP TR SPAWN DELAY',            'Autospawn (in ticks)',
                                       '��������� (� �����)'),
    ('PROP TR MONSTER TYPE',           'Monster',
                                       '��� �������'),
    ('PROP TR MONSTER ACTIVE',         'Active',
                                       '�������'),
    ('PROP TR MONSTER BEHAVIOUR',      'Behaviour',
                                       '���������'),
    ('PROP TR MONSTER BEHAVIOUR 0',    'Normal',
                                       '�������'),
    ('PROP TR MONSTER BEHAVIOUR 1',    'Killer',
                                       '������'),
    ('PROP TR MONSTER BEHAVIOUR 2',    'Maniac',
                                       '������'),
    ('PROP TR MONSTER BEHAVIOUR 3',    'Insane',
                                       '���������'),
    ('PROP TR MONSTER BEHAVIOUR 4',    'Cannibal',
                                       '��������'),
    ('PROP TR MONSTER BEHAVIOUR 5',    'Good',
                                       '������'),
    ('PROP TR ITEM TYPE',              'Item',
                                       '��� ��������'),
    ('PROP TR MUSIC NAME',             'Music',
                                       '������'),
    ('PROP TR MUSIC ACT',              'Action                             (m)',
                                       '��������                           (m)'),
    ('PROP TR MUSIC ON',               'Play',
                                       '��������'),
    ('PROP TR MUSIC OFF',              'Pause',
                                       '���������'),
    ('PROP TR PUSH ANGLE',             'Angle',
                                       '����'),
    ('PROP TR PUSH FORCE',             'Force',
                                       '����'),
    ('PROP TR PUSH RESET',             'Reset velocity',
                                       '���������� ��������'),
    ('PROP TR SCORE ACT',              'Action                             (s)',
                                       '��������                           (s)'),
    ('PROP TR SCORE ACT 0',            'Add points',
                                       '��������� ����'),
    ('PROP TR SCORE ACT 1',            'Subtract points',
                                       '������ ����'),
    ('PROP TR SCORE ACT 2',            'Team Wins',
                                       '�������'),
    ('PROP TR SCORE ACT 3',            'Team Loses',
                                       '��������'),
    ('PROP TR SCORE TEAM',             'Team',
                                       '�������'),
    ('PROP TR SCORE TEAM 0',           'My',
                                       '����'),
    ('PROP TR SCORE TEAM 1',           'Enemy',
                                       '���������'),
    ('PROP TR SCORE TEAM 2',           'Red',
                                       '�������'),
    ('PROP TR SCORE TEAM 3',           'Blue',
                                       '�����'),
    ('PROP TR SCORE CON',              'Console message',
                                       '��������� � �������'),
    ('PROP TR SCORE MSG',              'Game message',
                                       '��������� � ����'),
    ('PROP TR DAMAGE VALUE',           'Damage',
                                       '�����'),
    ('PROP TR HEALTH MAX',             'To maximum',
                                       '�� ���������'),
    ('PROP TR SHOT TYPE',              'Projectile',
                                       '������'),
    ('PROP TR SHOT SOUND',             'Shot sound',
                                       '���� ��������'),
    ('PROP TR SHOT ANGLE',             'Angle',
                                       '����'),
    ('PROP TR SHOT ACC',               'Spread',
                                       '�������'),
    ('PROP TR SHOT TO',                'Auto targeting',
                                       '�������������'),
    ('PROP TR SHOT TO 0',              'None',
                                       '���'),
    ('PROP TR SHOT TO 1',              'Monsters',
                                       '�������'),
    ('PROP TR SHOT TO 2',              'Players',
                                       '������'),
    ('PROP TR SHOT TO 3',              'Red team',
                                       '������� �������'),
    ('PROP TR SHOT TO 4',              'Blue team',
                                       '����� �������'),
    ('PROP TR SHOT TO 5',              'Monsters, players',
                                       '�������, ������'),
    ('PROP TR SHOT TO 6',              'Players, monsters',
                                       '������, �������'),
    ('PROP TR SHOT AIM',               'Auto-aiming mode',
                                       '����� �������������'),
    ('PROP TR SHOT AIM 0',             'Trigger area',
                                       '������� ��������'),
    ('PROP TR SHOT AIM 1',             'Entire map',
                                       '�� ���� �����'),
    ('PROP TR SHOT AIM 2',             'Trace trigger area',
                                       '������� �������� � ������������'),
    ('PROP TR SHOT AIM 3',             'Trace entire map',
                                       '��� ����� � ������������'),
    ('PROP TR SHOT AMMO',              'Ammo limit',
                                       '���-�� ��������'),
    ('PROP TR SHOT RELOAD',            'Reload interval (in ticks)',
                                       '����������� (� �����)'),
    ('PROP TR SHOT SIGHT',             'Sight interval (in ticks)',
                                       '������� (� �����)'),
    ('PROP TR SHOT PANEL',             'Indicator panel',
                                       '������ ���������'),
    ('PROP TR MESSAGE KIND',           'Message kind',
                                       '��� ���������'),
    ('PROP TR MESSAGE KIND 0',         'Console message',
                                       '����� � �������'),
    ('PROP TR MESSAGE KIND 1',         'Event message',
                                       '������� ����� �� ������'),
    ('PROP TR MESSAGE TO',             'Send to',
                                       '����������'),
    ('PROP TR MESSAGE TO 0',           'Me',
                                       '�'),
    ('PROP TR MESSAGE TO 1',           'My team',
                                       '��� �������'),
    ('PROP TR MESSAGE TO 2',           'Enemy team',
                                       '��������� �������'),
    ('PROP TR MESSAGE TO 3',           'Red team',
                                       '������� �������'),
    ('PROP TR MESSAGE TO 4',           'Blue team',
                                       '����� �������'),
    ('PROP TR MESSAGE TO 5',           'Everyone',
                                       '��� ������'),
    ('PROP TR MESSAGE TEXT',           'Message text',
                                       '����� ���������'),
    ('PROP TR MESSAGE TIME',           'Time (in ticks)',
                                       '����� ������ (� �����)'),
    ('PROP TR EFFECT TYPE',            'Effect type',
                                       '��� �������'),
    ('PROP TR EFFECT SUBTYPE',         'Effect subtype',
                                       '������ �������'),
    ('PROP TR EFFECT COLOR',           'Effect color',
                                       '���� �������'),
    ('PROP TR EFFECT CENTER',          'Trigger center',
                                       '�� ������'),
    ('PROP TR EFFECT VELX',            'Horizontal speed',
                                       '�������� �� �����������'),
    ('PROP TR EFFECT VELY',            'Vertical speed',
                                       '�������� �� ���������'),
    ('PROP TR EFFECT SPL',             'Speed variance left',
                                       '���������� �����'),
    ('PROP TR EFFECT SPR',             'Speed variance right',
                                       '���������� ������'),
    ('PROP TR EFFECT SPU',             'Speed variance up',
                                       '���������� �����'),
    ('PROP TR EFFECT SPD',             'Speed variance down',
                                       '���������� ����'),
    ('PROP TR EFFECT PARTICLE',        'Particle generator',
                                       '��������� ������'),
    ('PROP TR EFFECT ANIMATION',       'Animation',
                                       '��������'),
    ('PROP TR EFFECT SLIQUID',         'Water splash',
                                       '������ ����'),
    ('PROP TR EFFECT LLIQUID',         'Light colored splash',
                                       '������� ������ (�������)'),
    ('PROP TR EFFECT DLIQUID',         'Dark colored splash',
                                       '������� ������ (������)'),
    ('PROP TR EFFECT BLOOD',           'Blood',
                                       '�����'),
    ('PROP TR EFFECT SPARK',           'Sparks',
                                       '�����'),
    ('PROP TR EFFECT BUBBLE',          'Bubbles',
                                       '��������'),
    ('PROP TR SCRIPT PROC',            'Function name',
                                       '��� �������'),
    ('PROP TR SCRIPT ARG',             'Argument',
                                       '���. ��������'),

    ('MSG ERROR',                      'Error',
                                       '������'),
    ('MSG WRONG TEXWIDTH',             'Panel Width must be a multiple of Texture Width (%d)',
                                       '������ ������ ������ ���� ������ ������ �������� (%d)'),
    ('MSG WRONG TEXHEIGHT',            'Panel Height must be a multiple of Texture Height (%d)',
                                       '������ ������ ������ ���� ������ ������ �������� (%d)'),
    ('MSG WRONG ALPHA',                'Transparency must be in [0..255] interval',
                                       '������������ ������ ���� � ��������� [0..255]'),
    ('MSG WRONG SIZE',                 'Width and Height must be greater than 0',
                                       '������ � ������ ������ ���� ������ 0'),
    ('MSG WRONG XY',                   'X or Y coordinate hasn''t been set',
                                       '�� ������ X ��� Y ����������'),
    ('MSG TEXTURE ALREADY',            'Texture "%s" already exists',
                                       '�������� "%s" ��� ���������'),
    ('MSG RES NAME 64',                'Resource "%s" name must not be longer than 64 chars',
                                       '��� ������� "%s" ������ ���� �� ������� 64 ��������'),
    ('MSG CHOOSE ITEM',                'Select Item',
                                       '�������� �������'),
    ('MSG CHOOSE MONSTER',             'Select Monster',
                                       '�������� �������'),
    ('MSG CHOOSE AREA',                'Select Area',
                                       '�������� �������'),
    ('MSG CHOOSE TEXTURE',             'Select Texture',
                                       '�������� ��������'),
    ('MSG CHOOSE RES',                 'Resource hasn''t been selected',
                                       '�� ������ ������'),
    ('MSG EXIT',                       'Exit',
                                       '�����'),
    ('MSG EXIT PROMT',                 'Leaving so soon?',
                                       '��� �������?'),
    ('MSG DEL TEXTURE',                'Delete the texture',
                                       '������� ��������'),
    ('MSG DEL TEXTURE PROMT',          'Delete the texture "%s" ?',
                                       '������� �������� "%s" ?'),
    ('MSG DEL TEXTURE CANT',           'Can''t delete texture in use. Replace it on all panels with this texture.',
                                       '������ ������� ������������ ��������. �������� � �� ������ ������ � ���.'),
    ('MSG CLEAR MAP',                  'New map',
                                       '����� �����'),
    ('MSG CLEAR MAP PROMT',            'Clear the entire map?',
                                       '�������� ��� �����?'),
    ('MSG DELETE MAP',                 'Delete the map',
                                       '������� �����'),
    ('MSG DELETE MAP PROMT',           'Delete the map "%s" from "%s" ?',
                                       '������� ����� "%s" �� "%s" ?'),
    ('MSG MAP DELETED',                'Map is deleted',
                                       '����� �������'),
    ('MSG MAP DELETED PROMT',          'Map "%s" is deleted',
                                       '����� "%s" �������'),
    ('MSG EXEC ERROR',                 'Game execution error',
                                       '������ ������� ����'),
    ('MSG SOUND ERROR',                'Can''t play sound',
                                       '�� ������� ��������� ����'),
    ('MSG WAD ERROR',                  'Can''t open WAD: %s',
                                       '������ ��� �������� WAD: %s'),
    ('MSG RES ERROR',                  'Can''t read resource: %s:%s\%s',
                                       '������ ��� ������ �������: %s:%s\%s'),
    ('MSG PACKED',                     'Map "%s" with resources saved to "%s"',
                                       '����� "%s" ������ � ��������� ��������� � "%s"'),
    ('MSG MAP EXISTS',                 'Map "%s" already exists. Overwrite?',
                                       '����� "%s" ��� ����������. ��������?'),
    ('MSG SAVE MAP',                   'Save the map',
                                       '��������� �����'),

    ('HINT TELEPORT',                  'Choose destination of Teleport',
                                       '�������� ����� ���������'),
    ('HINT SPAWN',                     'Choose Spawn point',
                                       '�������� ����� ���������'),
    ('HINT PANEL DOOR',                'Choose Door',
                                       '�������� ������ �����'),
    ('HINT PANEL TEXTURE',             'Choose textured Panel',
                                       '�������� ������ � ���������'),
    ('HINT PANEL SHOT',                'Choose textured shot indicator Panel',
                                       '�������� ������ ��������� �������� � ���������'),
    ('HINT PANEL LIFT',                'Choose Stream Panel',
                                       '�������� ������ �����'),
    ('HINT MONSTER',                   'Choose Monster',
                                       '�������� �������'),
    ('HINT EXT AREA',                  'Specify action Area',
                                       '������� ������� �����������'),
    ('HINT WIDTH',                     'Width: %d',
                                       '������: %d'),
    ('HINT HEIGHT',                    'Height: %d',
                                       '������: %d'),

    ('MENU FILE',                      'File',
                                       '����'),
    ('MENU FILE NEW',                  'New Map',
                                       '����� �����'),
    ('MENU FILE OPEN',                 'Open Map',
                                       '������� �����'),
    ('MENU FILE SAVE',                 'Save Map',
                                       '��������� �����'),
    ('MENU FILE SAVE AS',              'Save Map As...',
                                       '��������� ����� ���...'),
    ('MENU FILE OPEN WAD',             'Select Map',
                                       '������� �����'),
    ('MENU FILE SAVE MINI',            'Save Mini-map',
                                       '��������� ����-�����'),
    ('MENU FILE DELETE',               'Delete Map from WAD...',
                                       '������� ����� �� WAD...'),
    ('MENU FILE PACK MAP',             'Pack Map',
                                       '��������� �����'),
    ('MENU FILE EXIT',                 'Exit',
                                       '�����'),

    ('MENU EDIT',                      'Edit',
                                       '������'),
    ('MENU EDIT UNDO',                 'Undo',
                                       '��������'),
    ('MENU EDIT COPY',                 'Copy',
                                       '����������'),
    ('MENU EDIT CUT',                  'Cut',
                                       '��������'),
    ('MENU EDIT PASTE',                'Paste',
                                       '��������'),
    ('MENU EDIT SELECT ALL',           'Select All',
                                       '�������� ��'),
    ('MENU EDIT TO FORE',              'Bring to Front',
                                       '����������� ������'),
    ('MENU EDIT TO BACK',              'Send to Back',
                                       '����������� �����'),

    ('MENU TOOLS',                     'Tools',
                                       '�����������'),
    ('MENU TOOLS SNAP GRID',           'Snap to Grid',
                                       '�������� � �����'),
    ('MENU TOOLS MINIMAP',             'Show Mini-map',
                                       '����-�����'),
    ('MENU TOOLS STEP GRID',           'Switch Grid step',
                                       '������� ��� �����'),
    ('MENU TOOLS SHOW EDGES',          'Switch Map edges',
                                       '������� �����'),
    ('MENU TOOLS LAYERS',              'Layers',
                                       '����'),

    ('MENU SERV',                      'Service',
                                       '������'),
    ('MENU SERV TEST',                 'Check the Map',
                                       '�������� �����'),
    ('MENU SERV OPT',                  'Optimize the Map',
                                       '����������� �����'),
    ('MENU SERV PREVIEW',              'Map Preview',
                                       '��������������� ��������'),
    ('MENU SERV LAUNCH',               'In-game test',
                                       '���� ����� � ����'),

    ('MENU SETS',                      'Settings',
                                       '���������'),
    ('MENU SETS MAP',                  'Map parameters',
                                       '��������� �����'),
    ('MENU SETS EDITOR',               'Editor settings',
                                       '��������� ���������'),
    ('MENU SETS LAUNCH',               'In-game test settings',
                                       '��������� ����� � ����'),

    ('MENU HELP',                      'Help',
                                       '�������'),
    ('MENU HELP ABOUT',                'About',
                                       '� ���������'),

    ('MENU LAYER BACK',                '1. Background',
                                       '1. ���'),
    ('MENU LAYER WALL',                '2. Walls',
                                       '2. �����'),
    ('MENU LAYER FORE',                '3. Foreground',
                                       '3. �������� ����'),
    ('MENU LAYER STAIR',               '4. Steps',
                                       '4. �������'),
    ('MENU LAYER WATER',               '5. Liquids',
                                       '5. ��������'),
    ('MENU LAYER ITEM',                '6. Items',
                                       '6. ��������'),
    ('MENU LAYER MONSTER',             '7. Monsters',
                                       '7. �������'),
    ('MENU LAYER AREA',                '8. Areas',
                                       '8. �������'),
    ('MENU LAYER TRIGGER',             '9. Triggers',
                                       '9. ��������'),

    ('MENU TB NEW',                    'New Map',
                                       '����� �����'),
    ('MENU TB OPEN',                   'Open Map',
                                       '������� �����'),
    ('MENU TB SAVE',                   'Save Map',
                                       '��������� �����'),
    ('MENU TB OPEN WAD',               'Open another Map from same WAD',
                                       '������� ������ ����� �� ����� �� WAD''�'),
    ('MENU TB MINIMAP',                'Show Mini-map',
                                       '�������� ����-�����'),
    ('MENU TB LAYERS',                 'Show/Hide Objects',
                                       '��������� �������/��������'),
    ('MENU TB GRID',                   'Grid On/Off',
                                       '��������/��������� ����������� �����'),
    ('MENU TB GRID STEP',              'Switch Grid step',
                                       '�������� ��� �����'),
    ('MENU TB LAUNCH',                 'In-game test',
                                       '���� ����� � ����'),

    ('MENU LAUNCH SETS',               'Settings...',
                                       '���������...'),

    ('CAP FX TYPE',                    'Select Effect type',
                                       '�������� ��� �������'),
    ('CAP MONSTER TYPE',               'Select Monster type',
                                       '�������� ��� �������'),
    ('CAP ITEM TYPE',                  'Select Item type',
                                       '�������� ��� ��������'),
    ('CAP ABOUT',                      'About Map Editor',
                                       '� ���������'),
    ('CAP ACT',                        'Activation type',
                                       '��� ���������'),
    ('CAP ADD SKY',                    'Select Sky Texture',
                                       '�������� �������� ����'),
    ('CAP ADD SOUND',                  'Select Sound/Music',
                                       '�������� ����/������'),
    ('CAP ADD TEXTURE',                'Select Texture',
                                       '�������� ��������'),
    ('CAP KEYS',                       'Keys',
                                       '�����'),
    ('CAP TEST',                       'Map Checking',
                                       '�������� �����'),
    ('CAP OPT',                        'Map Optimization',
                                       '����������� �����'),
    ('CAP SETS',                       'Map Parameters',
                                       '��������� �����'),
    ('CAP LAUNCH',                     'In-game test Settings',
                                       '��������� ����� � ����'),
    ('CAP ES',                         'Editor Settings',
                                       '��������� ���������'),
    ('CAP PACK',                       'Pack Map',
                                       '��������� �����'),
    ('CAP SAVE',                       'Save Map',
                                       '��������� �����'),
    ('CAP MINI',                       'Save Mini-map',
                                       '��������� ����-�����'),
    ('CAP SELECT',                     'Select Map',
                                       '�������� �����'),

    ('CTRL PROP KEY',                  'Property',
                                       '��������'),
    ('CTRL PROP VALUE',                'Value',
                                       '��������'),

    ('CTRL PANELS',                    'Panels',
                                       '������'),
    ('CTRL ITEMS',                     'Items',
                                       '��������'),
    ('CTRL MONSTERS',                  'Monsters',
                                       '�������'),
    ('CTRL AREAS',                     'Areas',
                                       '�������'),
    ('CTRL TRIGGERS',                  'Triggers',
                                       '��������'),

    ('CTRL LIST TEXTURE',              'Texture List',
                                       '������ �������'),
    ('CTRL LIST ITEM',                 'Item List',
                                       '������ ���������'),
    ('CTRL LIST MONSTER',              'Monster List',
                                       '������ ��������'),
    ('CTRL LIST AREA',                 'Area List',
                                       '������ ��������'),
    ('CTRL LIST TRIGGER',              'Trigger List',
                                       '������ ���������'),
    ('CTRL LIST ACTIVE',               'Activation Type',
                                       '��� ��������� ��������'),
    ('CTRL LIST KEYS',                 'Keys Needed',
                                       '����� ��� ���������'),

    ('CTRL PREVIEW',                   'Texture Preview',
                                       '��������������� ��������'),
    ('CTRL ITEM DM',                   'DM Only',
                                       '������ � DM'),
    ('CTRL ITEM FALLS',                'Falls',
                                       '������'),
    ('CTRL LEFT',                      'Left',
                                       '�����'),
    ('CTRL RIGHT',                     'Right',
                                       '������'),

    ('CTRL ACT PLAYER CLOSE',          'Player Collides',
                                       '����� ������'),
    ('CTRL ACT MONSTER CLOSE',         'Monster Collides',
                                       '������ ������'),
    ('CTRL ACT PLAYER PRESS',          'Player Pressed',
                                       '����� �����'),
    ('CTRL ACT MONSTER PRESS',         'Monster Pressed',
                                       '������ �����'),
    ('CTRL ACT SHOT',                  'Shot',
                                       '�������'),
    ('CTRL ACT NO MONSTER',            'No Monsters',
                                       '�������� ���'),

    ('CTRL KEYS RED',                  'Red Key',
                                       '������� ����'),
    ('CTRL KEYS GREEN',                'Green Key',
                                       '������� ����'),
    ('CTRL KEYS BLUE',                 'Blue Key',
                                       '����� ����'),
    ('CTRL KEYS TEAM RED',             'Red Team',
                                       '������� �������'),
    ('CTRL KEYS TEAM BLUE',            'Blue Team',
                                       '����� �������'),

    ('CTRL OPT GB',                    'Optimization',
                                       '�����������'),
    ('CTRL OPT TEXTURE',               'Texture Optimization',
                                       '����������� �������'),
    ('CTRL OPT PANEL',                 'Panel Optimization',
                                       '����������� �������'),
    ('CTRL OPT WALL',                  'Walls',
                                       '�����'),
    ('CTRL OPT FORE',                  'Foreground',
                                       '�������� ����'),
    ('CTRL OPT BACK',                  'Background',
                                       '���'),
    ('CTRL OPT STAIR',                 'Steps',
                                       '�������'),
    ('CTRL OPT WATER',                 'Water',
                                       '����'),
    ('CTRL OPT ACID1',                 'Acid 1',
                                       '������� 1'),
    ('CTRL OPT ACID2',                 'Acid 2',
                                       '������� 2'),
    ('CTRL OPT LIFT',                  'Streams',
                                       '�����'),
    ('CTRL OPT BLOCKMON',              'Monster Boundary',
                                       '���������� ��������'),
    ('CTRL OPT DESC TEXTURE',          'Deletes unused textures from texture list.',
                                       '������� �������������� �������� �� ������.'),
    ('CTRL OPT DESC PANEL',            'Merges nearby panels of same type. Increases game performance.',
                                       '���������� ���������� ������, ������������� �������� ���� � �����, ���������� ��� ����� ������������������ ����.'),
    ('CTRL SETS STATS',                'Statistics:',
                                       '����������:'),
    ('CTRL SETS SIZES',                'Map Size:',
                                       '�������:'),

    ('CTRL LAUNCH DM',                 'Deathmatch',
                                       'Deathmatch'),
    ('CTRL LAUNCH TDM',                'Team Deathmatch',
                                       'Team Deathmatch'),
    ('CTRL LAUNCH CTF',                'Capture the Flag',
                                       'Capture the Flag'),
    ('CTRL LAUNCH COOP',               'Cooperative',
                                       'Cooperative'),
    ('CTRL LAUNCH 2P',                 'Two Players',
                                       '��� ������'),
    ('CTRL LAUNCH FF',                 'Friendly Fire',
                                       '���� �����'),
    ('CTRL LAUNCH EXIT',               'Enable Exit',
                                       '�������� �����'),
    ('CTRL LAUNCH WEAPONS',            'Weapons Stay',
                                       '������ �������'),
    ('CTRL LAUNCH MONSTERS',           'Enable Monsters',
                                       '������� � DM'),
    ('CTRL LAUNCH CLOSE',              'Close the game after exiting the map',
                                       '������� ���� ����� ������ �� �����'),
    ('CTRL LAUNCH OPEN',               'Select Doom 2D: Forever .exe',
                                       '�������� ���� ���� Doom 2D: Forever'),

    ('CTRL ES GRID',                   'Show Grid',
                                       '���������� �����'),
    ('CTRL ES TEXTURE',                'Show Panel Texture',
                                       '���������� �������� ������'),
    ('CTRL ES PANEL SIZE',             'Show Panel Size',
                                       '���������� ������� ������ '),

    ('CTRL PACK TEXTURES',             'Textures',
                                       '��������'),
    ('CTRL PACK SKY',                  'Sky',
                                       '����'),
    ('CTRL PACK MUSIC',                'Music',
                                       '������'),
    ('CTRL PACK ADD',                  'Don''t overwrite WAD',
                                       '�� �������������� WAD'),
    ('CTRL PACK NON STD',              'Non-standard Resources only',
                                       '������ ������������� �������'),

    ('LAB TEX WIDTH',                  'Texture Width:',
                                       '������ ��������:'),
    ('LAB TEX HEIGHT',                 'Texture Height:',
                                       '������ ��������:'),

    ('LAB SPECTRUM',                   'Show the Spectrum',
                                       '�������� ������'),

    ('LAB ABOUT VER',                  'Version 2.1.5',
                                       '������ 2.1.5'),
    ('LAB ABOUT AUTHOR',               'Author: rs.falcon',
                                       '�����: rs.falcon'),
    ('LAB ABOUT AUTHOR 2',             'Additions: Pss',
                                       '�����������: Pss'),
    ('LAB ABOUT MAIL',                 'rmw.falcon@mail.ru',
                                       'rmw.falcon@mail.ru'),
    ('LAB ABOUT MAIL 2',               'pssxx@mail.ru',
                                       'pssxx@mail.ru'),
    ('LAB ABOUT SITE',                 'Doom 2D: Forever Web-site',
                                       '���� Doom 2D: Forever'),
    ('LAB ABOUT HTTP',                 'www.doom2d.org',
                                       'www.doom2d.org'),

    ('LAB ADD WADS',                   'WAD Files:',
                                       '������ WAD-������:'),
    ('LAB ADD SECTIONS',               'WAD Sections:',
                                       '������ ������ WAD-�����:'),

    ('LAB SETS NAME',                  'Map Name:',
                                       '�������� �����:'),
    ('LAB SETS DESC',                  'Map Description',
                                       '�������� �����:'),
    ('LAB SETS AUTHOR',                'Author:',
                                       '�����:'),
    ('LAB SETS BACK',                  'Background/Sky:',
                                       '���/����:'),
    ('LAB SETS MUSIC',                 'Music:',
                                       '������:'),
    ('LAB SETS TEXTURES',              'Textures:',
                                       '�������:'),
    ('LAB SETS PANELS',                'Panels:',
                                       '�������:'),
    ('LAB SETS ITEMS',                 'Items:',
                                       '���������:'),
    ('LAB SETS MONSTERS',              'Monsters:',
                                       '��������:'),
    ('LAB SETS AREAS',                 'Areas:',
                                       '��������:'),
    ('LAB SETS TRIGGERS',              'Triggers:',
                                       '���������:'),
    ('LAB SETS SIZES',                 'Current:',
                                       '�������:'),
    ('LAB SETS WIDTH',                 'Width:',
                                       '������:'),
    ('LAB SETS HEIGHT',                'Height:',
                                       '������:'),
    ('LAB SETS MAPMOVE',               'Direction of shifting map objects:',
                                       '����������� �������� �������� �����:'),
    ('LAB SETS SNAPPING',              'Preserve snapping',
                                       '��������� ��������'),

    ('LAB LAUNCH TIME',                'Time Limit:',
                                       '����� �������:'),
    ('LAB LAUNCH SECS',                'seconds',
                                       '������'),
    ('LAB LAUNCH SCORE',               'Score Limit:',
                                       '����� �����:'),
    ('LAB LAUNCH PATH',                'Path to Doom2DF.exe:',
                                       '���� � Doom2DF.exe:'),

    ('LAB ES GRID',                    'Grid Step:',
                                       '��� �����:'),
    ('LAB ES GRID COLOR',              'Grid Color:',
                                       '���� �����:'),
    ('LAB ES BACK',                    'Background Color:',
                                       '���� ����:'),
    ('LAB ES PREVIEW',                 'Texture Preview Background Color:',
                                       '���� ���� ���� ������������� ��������:'),
    ('LAB ES MINIMAP',                 'Mini-map Scale:',
                                       '������� ����-�����:'),
    ('LAB ES RECENT',                  'Recent Maps List Contains:',
                                       '���������� ��������� �������� ����:'),
    ('LAB ES LANGUAGE',                'Language:',
                                       '����:'),

    ('LAB PACK SAVE TO',               'Save to:',
                                       '��������� �:'),
    ('LAB PACK MAP NAME',              'Map Resource Name:',
                                       '�������� ������� �����:'),
    ('LAB PACK TEXTURES',              'Texture Section:',
                                       '������ ��� �������:'),
    ('LAB PACK SKY',                   'Sky Section:',
                                       '������ ��� ����:'),
    ('LAB PACK MUSIC',                 'Music Section:',
                                       '������ ��� ������:'),

    ('LAB MINI SCALE',                 'Scale:',
                                       '�������:'),

    ('BTN APPLY PROPS',                'Apply Properties',
                                       '��������� ��������'),
    ('BTN OK',                         'OK',
                                       'OK'),
    ('BTN CANCEL',                     'Cancel',
                                       '������'),
    ('BTN ADD',                        'Add',
                                       '��������'),
    ('BTN CLOSE',                      'Close',
                                       '�������'),
    ('BTN ADD CLOSE',                  'Add and Close',
                                       '�������� � �������'),
    ('BTN TEST AGAIN',                 'Check',
                                       '���������'),
    ('BTN START',                      'Run',
                                       '������'),
    ('BTN PACK',                       'Pack',
                                       '���������'),
    ('BTN SAVE',                       'Save',
                                       '���������'),
    ('BTN NO SOUND',                   'No sound',
                                       '��� �����'),
    ('BTN TEXTURE ADD',                'Add texture to the list',
                                       '�������� �������� � ������'),
    ('BTN TEXTURE DELETE',             'Delete texture from the list',
                                       '������� �������� �� ������'),
    ('BTN TEXTURE EMPTY',              'Deselect texture',
                                       '����� ����� � ��������'),

    ('LOAD WAD',                       'Reading WAD',
                                       '������ WAD'),
    ('LOAD MAP',                       'Loading Map',
                                       '������ �����'),
    ('LOAD TEXTURES',                  'Reading Textures',
                                       '������ �������'),
    ('LOAD PANELS',                    'Reading Panels',
                                       '������ �������'),
    ('LOAD ITEMS',                     'Reading Items',
                                       '������ ���������'),
    ('LOAD MONSTERS',                  'Reading Monsters',
                                       '������ ��������'),
    ('LOAD AREAS',                     'Reading Areas',
                                       '������ ��������'),
    ('LOAD TRIGGERS',                  'Reading Triggers',
                                       '������ ���������'),

    ('TEST AREA WALL',                 'Player collides with the wall and will be stuck.',
                                       '���� � ���� ������� �������� �����, �� �� ��������� � ����� � �� ������ ���������.'),
    ('TEST AREA WALL STR',             'Area #%d collides with Map (%d:%d)',
                                       '������� #%d ������������ � ������ (%d:%d)'),
    ('TEST SPAWNS 1',                  'There are several spawn points for First Player on the map',
                                       '��������� ����� ��������� ������� ������'),
    ('TEST SPAWNS 2',                  'There are several spawn points for Second Player on the map',
                                       '��������� ����� ��������� ������� ������'),
    ('TEST SPAWNS',                    'There are several spawn points on the map. Random one will be used.',
                                       '��������� ����� ��������� ������, ����� ������������ ���������.'),
    ('TEST NO DM',                     'There are no DM spawn points on the map',
                                       '�� ����� ��� ����� DM'),
    ('TEST NO DM EX',                  'There are no DM spawn points on the map. Only "Single Player" mode available.',
                                       '�� ����� ��� ����� DM, �������� ��������� ������ � ������ "Single Player".'),
    ('TEST MONSTER WALL',              'Monster collides with the wall and will be stuck.',
                                       '������ ������������ � ������. �� ��������� � ����� � �� ������ ���������'),
    ('TEST MONSTER WALL STR',          'Monster #%d collides with a map (%d:%d)',
                                       '������ #%d ������������ � ������ (%d:%d)'),

    ('OPT NO TEXTURES',                'Texture list is empty',
                                       '������ ������� ����'),
    ('OPT DELETED TEXTURES',           'Deleted Textures:',
                                       '�������� ��������:'),
    ('OPT TOTAL TEXTURES',             'Textures Total:',
                                       '����� �������:'),
    ('OPT TEX DELETED',                'Textures Deleted:',
                                       '������� �������:'),
    ('OPT PANELS OPT',                 'Panels Optimized:',
                                       '�������������� �������:'),
    ('OPT WALLS',                      'Walls Optimization...',
                                       '����������� ����...'),
    ('OPT FORES',                      'Foreground Optimization...',
                                       '����������� ��������� �����...'),
    ('OPT BACKS',                      'Background Optimization...',
                                       '����������� ����...'),
    ('OPT STAIRS',                     'Steps Optimization...',
                                       '����������� ��������...'),
    ('OPT WATER',                      'Water Optimization...',
                                       '����������� ����...'),
    ('OPT ACID1',                      'Acid 1 Optimization...',
                                       '����������� ������� 1...'),
    ('OPT ACID2',                      'Acid 2 Optimization...',
                                       '����������� ������� 2...'),
    ('OPT LIFTS',                      'Streams Optimization...',
                                       '����������� ������...'),
    ('OPT BLOCKMON',                   'Monster Boundaries Optimization...',
                                       '����������� ������������ ��������....'), 
    ('OPT TOTAL PANELS',               'Panels Total:',
                                       '����� �������:'),
    ('OPT PANELS AFTER',               'Panels after Optimization:',
                                       '������� ����� �����������:'),

    ('WAD SPECIAL MAP',                '<MAP WAD-FILE>',
                                       '<WAD-���� �����>'),
    ('WAD SPECIAL TEXS',               '<EXTRA TEXTURES>',
                                       '<������������>'),

    ('FILE FILTER ALL',                'Doom 2D: Forever Maps (*.wad)|*.wad|Old Doom 2D: Forever 0.30 Maps (*.ini)|*.ini|All Files (*.*)|*.*',
                                       '����� Doom 2D: Forever (*.wad)|*.wad|������ ����� Doom 2D: Forever 0.30 (*.ini)|*.ini|��� ����� (*.*)|*.*'),
    ('FILE FILTER WAD',                'Doom 2D: Forever Maps (*.wad)|*.wad|All Files (*.*)|*.*',
                                       '����� Doom 2D: Forever (*.wad)|*.wad|��� ����� (*.*)|*.*'),

    ('EDITOR TITLE',                   'Doom 2D: Forever Map Editor',
                                       '�������� ���� Doom 2D: Forever'),

                                       
    ('', '', '') );


procedure SetupArrays();
var
  i: Integer;

begin
// ��/���:
  BoolNames[False] := _lc[I_ARRAY_BOOL_FALSE];
  BoolNames[True] := _lc[I_ARRAY_BOOL_TRUE];

// �����������:
  DirNames[D_LEFT] := _lc[I_ARRAY_DIR_LEFT];
  DirNames[D_RIGHT] := _lc[I_ARRAY_DIR_RIGHT];

// ����� �����������:
  DirNamesAdv[0] := _lc[I_ARRAY_DIR_SAME];
  DirNamesAdv[1] := _lc[I_ARRAY_DIR_LEFT];
  DirNamesAdv[2] := _lc[I_ARRAY_DIR_RIGHT];
  DirNamesAdv[3] := _lc[I_ARRAY_DIR_REVERSED];

// ����������� (�� �������):
  DirButtonNames[1] := _lc[I_ARRAY_DIRBTN_LEFT];
  DirButtonNames[2] := _lc[I_ARRAY_DIRBTN_RIGHT];
  DirButtonNames[3] := _lc[I_ARRAY_DIRBTN_UP];
  DirButtonNames[4] := _lc[I_ARRAY_DIRBTN_DOWN];

// �������� �������:
  PANELNAMES[0] := _lc[I_ARRAY_PANEL_WALL];
  PANELNAMES[1] := _lc[I_ARRAY_PANEL_BACK];
  PANELNAMES[2] := _lc[I_ARRAY_PANEL_FRONT];
  PANELNAMES[3] := _lc[I_ARRAY_PANEL_DOOR_OPEN];
  PANELNAMES[4] := _lc[I_ARRAY_PANEL_DOOR_CLOSE];
  PANELNAMES[5] := _lc[I_ARRAY_PANEL_STAIR];
  PANELNAMES[6] := _lc[I_ARRAY_PANEL_WATER];
  PANELNAMES[7] := _lc[I_ARRAY_PANEL_ACID_1];
  PANELNAMES[8] := _lc[I_ARRAY_PANEL_ACID_2];
  PANELNAMES[9] := _lc[I_ARRAY_PANEL_LIFT_UP];
  PANELNAMES[10] := _lc[I_ARRAY_PANEL_LIFT_DOWN];
  PANELNAMES[11] := _lc[I_ARRAY_PANEL_LIFT_LEFT];
  PANELNAMES[12] := _lc[I_ARRAY_PANEL_LIFT_RIGHT];
  PANELNAMES[13] := _lc[I_ARRAY_PANEL_BLOCKMON];

// �������� ��������:
  EffectNames[EFFECT_NONE] := _lc[I_ARRAY_FX_NONE];
  EffectNames[EFFECT_TELEPORT] := _lc[I_ARRAY_FX_TELEPORT];
  EffectNames[EFFECT_RESPAWN] := _lc[I_ARRAY_FX_RESPAWN];
  EffectNames[EFFECT_FIRE] := _lc[I_ARRAY_FX_FIRE];

// �������� ���������:
  ItemNames[ITEM_MEDKIT_SMALL] := _lc[I_ARRAY_ITEM_MEDKIT];
  ItemNames[ITEM_MEDKIT_LARGE] := _lc[I_ARRAY_ITEM_LARGE_MEDKIT];
  ItemNames[ITEM_MEDKIT_BLACK] := _lc[I_ARRAY_ITEM_BLACK_MEDKIT];
  ItemNames[ITEM_ARMOR_GREEN] := _lc[I_ARRAY_ITEM_GREEN_ARMOR];
  ItemNames[ITEM_ARMOR_BLUE] := _lc[I_ARRAY_ITEM_BLUE_ARMOR];
  ItemNames[ITEM_SPHERE_BLUE] := _lc[I_ARRAY_ITEM_BLUE_SPHERE];
  ItemNames[ITEM_SPHERE_WHITE] := _lc[I_ARRAY_ITEM_MEGASPHERE];
  ItemNames[ITEM_SUIT] := _lc[I_ARRAY_ITEM_HAZ_SUIT];
  ItemNames[ITEM_OXYGEN] := _lc[I_ARRAY_ITEM_OXYGEN];
  ItemNames[ITEM_INVUL] := _lc[I_ARRAY_ITEM_INVULNERABILITY];
  ItemNames[ITEM_WEAPON_SAW] := _lc[I_ARRAY_ITEM_CHAINSAW];
  ItemNames[ITEM_WEAPON_SHOTGUN1] := _lc[I_ARRAY_ITEM_SHOTGUN];
  ItemNames[ITEM_WEAPON_SHOTGUN2] := _lc[I_ARRAY_ITEM_DB_SHOTGUN];
  ItemNames[ITEM_WEAPON_CHAINGUN] := _lc[I_ARRAY_ITEM_CHAINGUN];
  ItemNames[ITEM_WEAPON_ROCKETLAUNCHER] := _lc[I_ARRAY_ITEM_ROCKET_LAUNCHER];
  ItemNames[ITEM_WEAPON_PLASMA] := _lc[I_ARRAY_ITEM_PLASMA_RIFLE];
  ItemNames[ITEM_WEAPON_BFG] := _lc[I_ARRAY_ITEM_BFG];
  ItemNames[ITEM_WEAPON_SUPERPULEMET] := _lc[I_ARRAY_ITEM_SUPER_MINIGUN];
  ItemNames[ITEM_AMMO_BULLETS] := _lc[I_ARRAY_ITEM_CLIP];
  ItemNames[ITEM_AMMO_BULLETS_BOX] := _lc[I_ARRAY_ITEM_AMMO_BOX];
  ItemNames[ITEM_AMMO_SHELLS] := _lc[I_ARRAY_ITEM_4_SHELLS];
  ItemNames[ITEM_AMMO_SHELLS_BOX] := _lc[I_ARRAY_ITEM_25_SHELLS];
  ItemNames[ITEM_AMMO_ROCKET] := _lc[I_ARRAY_ITEM_1_ROCKET];
  ItemNames[ITEM_AMMO_ROCKET_BOX] := _lc[I_ARRAY_ITEM_ROCKET_BOX];
  ItemNames[ITEM_AMMO_CELL] := _lc[I_ARRAY_ITEM_CELL];
  ItemNames[ITEM_AMMO_CELL_BIG] := _lc[I_ARRAY_ITEM_LARGE_CELL];
  ItemNames[ITEM_AMMO_BACKPACK] := _lc[I_ARRAY_ITEM_BACKPACK];
  ItemNames[ITEM_KEY_RED] := _lc[I_ARRAY_ITEM_KEY_RED];
  ItemNames[ITEM_KEY_GREEN] := _lc[I_ARRAY_ITEM_KEY_GREEN];
  ItemNames[ITEM_KEY_BLUE] := _lc[I_ARRAY_ITEM_KEY_BLUE];
  ItemNames[ITEM_WEAPON_KASTET] := '?';
  ItemNames[ITEM_WEAPON_PISTOL] := '??';
  ItemNames[ITEM_BOTTLE] := _lc[I_ARRAY_ITEM_BOTTLE];
  ItemNames[ITEM_HELMET] := _lc[I_ARRAY_ITEM_HELMET];
  ItemNames[ITEM_JETPACK] := _lc[I_ARRAY_ITEM_JETPACK];
  ItemNames[ITEM_INVIS] := _lc[I_ARRAY_ITEM_INVIS];

// �������� ��������:
  ShotNames[TRIGGER_SHOT_PISTOL] := _lc[I_ARRAY_SHOT_PISTOL];
  ShotNames[TRIGGER_SHOT_BULLET] := _lc[I_ARRAY_SHOT_BULLET];
  ShotNames[TRIGGER_SHOT_SHOTGUN] := _lc[I_ARRAY_SHOT_SHOTGUN];
  ShotNames[TRIGGER_SHOT_SSG] := _lc[I_ARRAY_SHOT_SSG];
  ShotNames[TRIGGER_SHOT_IMP] := _lc[I_ARRAY_SHOT_IMP];
  ShotNames[TRIGGER_SHOT_PLASMA] := _lc[I_ARRAY_SHOT_PLASMA];
  ShotNames[TRIGGER_SHOT_SPIDER] := _lc[I_ARRAY_SHOT_SPIDER];
  ShotNames[TRIGGER_SHOT_CACO] := _lc[I_ARRAY_SHOT_CACO];
  ShotNames[TRIGGER_SHOT_BARON] := _lc[I_ARRAY_SHOT_BARON];
  ShotNames[TRIGGER_SHOT_MANCUB] := _lc[I_ARRAY_SHOT_MANCUB];
  ShotNames[TRIGGER_SHOT_REV] := _lc[I_ARRAY_SHOT_REV];
  ShotNames[TRIGGER_SHOT_ROCKET] := _lc[I_ARRAY_SHOT_ROCKET];
  ShotNames[TRIGGER_SHOT_BFG] := _lc[I_ARRAY_SHOT_BFG];
  ShotNames[TRIGGER_SHOT_EXPL] := _lc[I_ARRAY_SHOT_EXPL];
  ShotNames[TRIGGER_SHOT_BFGEXPL] := _lc[I_ARRAY_SHOT_BFGEXPL];

// �������� ��������:
  MonsterNames[MONSTER_DEMON] := _lc[I_ARRAY_MON_DEMON];
  MonsterNames[MONSTER_IMP] := _lc[I_ARRAY_MON_IMP];
  MonsterNames[MONSTER_ZOMBY] := _lc[I_ARRAY_MON_ZOMBIE];
  MonsterNames[MONSTER_SERG] := _lc[I_ARRAY_MON_SERGEANT];
  MonsterNames[MONSTER_CYBER] := _lc[I_ARRAY_MON_CYBER];
  MonsterNames[MONSTER_CGUN] := _lc[I_ARRAY_MON_CGUN];
  MonsterNames[MONSTER_BARON] := _lc[I_ARRAY_MON_HELL_BARON];
  MonsterNames[MONSTER_KNIGHT] := _lc[I_ARRAY_MON_HELL_KNIGHT];
  MonsterNames[MONSTER_CACO] := _lc[I_ARRAY_MON_CACODEMON];
  MonsterNames[MONSTER_SOUL] := _lc[I_ARRAY_MON_LOST_SOUL];
  MonsterNames[MONSTER_PAIN] := _lc[I_ARRAY_MON_PAIN_ELEMENTAL];
  MonsterNames[MONSTER_SPIDER] := _lc[I_ARRAY_MON_MASTERMIND];
  MonsterNames[MONSTER_BSP] := _lc[I_ARRAY_MON_ARACHNATRON];
  MonsterNames[MONSTER_MANCUB] := _lc[I_ARRAY_MON_MANCUBUS];
  MonsterNames[MONSTER_SKEL] := _lc[I_ARRAY_MON_REVENANT];
  MonsterNames[MONSTER_VILE] := _lc[I_ARRAY_MON_ARCHVILE];
  MonsterNames[MONSTER_FISH] := _lc[I_ARRAY_MON_FISH];
  MonsterNames[MONSTER_BARREL] := _lc[I_ARRAY_MON_BARREL];
  MonsterNames[MONSTER_ROBO] := _lc[I_ARRAY_MON_ROBOT];
  MonsterNames[MONSTER_MAN] := _lc[I_ARRAY_MON_PRIKOLIST];

// �������� ��������:
  AreaNames[AREA_PLAYERPOINT1] := _lc[I_ARRAY_AREA_PLAYER_ONE];
  AreaNames[AREA_PLAYERPOINT2] := _lc[I_ARRAY_AREA_PLAYER_TWO];
  AreaNames[AREA_DMPOINT] := _lc[I_ARRAY_AREA_DM];
  AreaNames[AREA_REDFLAG] := _lc[I_ARRAY_AREA_FLAG_RED];
  AreaNames[AREA_BLUEFLAG] := _lc[I_ARRAY_AREA_FLAG_BLUE];
  AreaNames[AREA_DOMFLAG] := _lc[I_ARRAY_AREA_FLAG_DOM];
  AreaNames[AREA_REDTEAMPOINT] := _lc[I_ARRAY_AREA_TEAM_RED];
  AreaNames[AREA_BLUETEAMPOINT] := _lc[I_ARRAY_AREA_TEAM_BLUE];

// �������� ���������:
  TriggerNames[TRIGGER_EXIT] := _lc[I_ARRAY_TR_EXIT];
  TriggerNames[TRIGGER_TELEPORT] := _lc[I_ARRAY_TR_TELEPORT];
  TriggerNames[TRIGGER_OPENDOOR] := _lc[I_ARRAY_TR_DOOR_OPEN];
  TriggerNames[TRIGGER_CLOSEDOOR] := _lc[I_ARRAY_TR_DOOR_CLOSE];
  TriggerNames[TRIGGER_DOOR] := _lc[I_ARRAY_TR_DOOR_SWITCH];
  TriggerNames[TRIGGER_DOOR5] := _lc[I_ARRAY_TR_DOOR_5_SEC];
  TriggerNames[TRIGGER_CLOSETRAP] := _lc[I_ARRAY_TR_TRAP_CLOSE];
  TriggerNames[TRIGGER_TRAP] := _lc[I_ARRAY_TR_TRAP];
  TriggerNames[TRIGGER_PRESS] := _lc[I_ARRAY_TR_EXTEND];
  TriggerNames[TRIGGER_SECRET] := _lc[I_ARRAY_TR_SECRET];
  TriggerNames[TRIGGER_LIFTUP] := _lc[I_ARRAY_TR_LIFT_UP];
  TriggerNames[TRIGGER_LIFTDOWN] := _lc[I_ARRAY_TR_LIFT_DOWN];
  TriggerNames[TRIGGER_LIFT] := _lc[I_ARRAY_TR_LIFT_SWITCH];
  TriggerNames[TRIGGER_TEXTURE] := _lc[I_ARRAY_TR_TEXTURE];
  TriggerNames[TRIGGER_ON] := _lc[I_ARRAY_TR_ON];
  TriggerNames[TRIGGER_OFF] := _lc[I_ARRAY_TR_OFF];
  TriggerNames[TRIGGER_ONOFF] := _lc[I_ARRAY_TR_SWITCH];
  TriggerNames[TRIGGER_SOUND] := _lc[I_ARRAY_TR_SOUND];
  TriggerNames[TRIGGER_SPAWNMONSTER] := _lc[I_ARRAY_TR_SPAWN_MONSTER];
  TriggerNames[TRIGGER_SPAWNITEM] := _lc[I_ARRAY_TR_SPAWN_ITEM];
  TriggerNames[TRIGGER_MUSIC] := _lc[I_ARRAY_TR_MUSIC];
  TriggerNames[TRIGGER_PUSH] := _lc[I_ARRAY_TR_PUSH];
  TriggerNames[TRIGGER_SCORE] := _lc[I_ARRAY_TR_SCORE];
  TriggerNames[TRIGGER_MESSAGE] := _lc[I_ARRAY_TR_MESSAGE];
  TriggerNames[TRIGGER_DAMAGE] := _lc[I_ARRAY_TR_DAMAGE];
  TriggerNames[TRIGGER_HEALTH] := _lc[I_ARRAY_TR_HEALTH];
  TriggerNames[TRIGGER_SHOT] := _lc[I_ARRAY_TR_SHOT];
  TriggerNames[TRIGGER_EFFECT] := _lc[I_ARRAY_TR_EFFECT];
  TriggerNames[TRIGGER_SCRIPT] := _lc[I_ARRAY_TR_SCRIPT];

// ��������� �������� � ������ ������ ��������:
  with MainForm do
  begin
    lbPanelType.Items.Clear();
    for i := 0 to High(PANELNAMES) do
      lbPanelType.Items.Add(PANELNAMES[i]);
    lbPanelType.ItemIndex := 0;

    lbItemList.Clear();
    for i := ITEM_MEDKIT_SMALL to ITEM_KEY_BLUE do
      lbItemList.Items.Add(ItemNames[i]);
    lbItemList.Items.Add(ItemNames[ITEM_BOTTLE]);
    lbItemList.Items.Add(ItemNames[ITEM_HELMET]);
    lbItemList.Items.Add(ItemNames[ITEM_JETPACK]);
    lbItemList.Items.Add(ItemNames[ITEM_INVIS]);

    lbMonsterList.Clear();
    for i := MONSTER_DEMON to MONSTER_MAN do
      lbMonsterList.Items.Add(MonsterNames[i]);

    lbAreasList.Clear();
    for i := AREA_PLAYERPOINT1 to AREA_BLUETEAMPOINT do
      lbAreasList.Items.Add(AreaNames[i]);

    lbTriggersList.Clear();
    for i := Low(TriggerNames) to High(TriggerNames) do
      lbTriggersList.Items.Add(TriggerNames[i]);

    clbActivationType.Clear();
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_PLAYER_CLOSE]);
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_MONSTER_CLOSE]);
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_PLAYER_PRESS]);
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_MONSTER_PRESS]);
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_SHOT]);
    clbActivationType.Items.Add(_lc[I_CTRL_ACT_NO_MONSTER]);

    clbKeys.Clear();
    clbKeys.Items.Add(_lc[I_CTRL_KEYS_RED]);
    clbKeys.Items.Add(_lc[I_CTRL_KEYS_GREEN]);
    clbKeys.Items.Add(_lc[I_CTRL_KEYS_BLUE]);
    clbKeys.Items.Add(_lc[I_CTRL_KEYS_TEAM_RED]);
    clbKeys.Items.Add(_lc[I_CTRL_KEYS_TEAM_BLUE]);
  end;
end;

procedure SetupCaptions();
var
  i: Integer;

begin
// ������� �����:
  with MainForm do
  begin
  // ���������:
    FormCaption := _lc[I_EDITOR_TITLE];
    i := Pos('-', Caption);
    if i > 0 then
      begin
        Caption := FormCaption + ' ' + Copy(Caption, i, Length(Caption)-i+1);
      end
    else
      Caption := FormCaption;
  // ������� ����:
  // "����":
    miMenuFile.Caption := _lc[I_MENU_FILE];
    miNewMap.Caption := _lc[I_MENU_FILE_NEW];
    miOpenMap.Caption := _lc[I_MENU_FILE_OPEN];
    miSaveMap.Caption := _lc[I_MENU_FILE_SAVE];
    miSaveMapAs.Caption := _lc[I_MENU_FILE_SAVE_AS];
    miOpenWadMap.Caption := _lc[I_MENU_FILE_OPEN_WAD];
    miSaveMiniMap.Caption := _lc[I_MENU_FILE_SAVE_MINI];
    miDeleteMap.Caption := _lc[I_MENU_FILE_DELETE];
    miPackMap.Caption := _lc[I_MENU_FILE_PACK_MAP];
    miExit.Caption := _lc[I_MENU_FILE_EXIT];
  // "������":
    miMenuEdit.Caption := _lc[I_MENU_EDIT];
    miUndo.Caption := _lc[I_MENU_EDIT_UNDO];
    miCopy.Caption := _lc[I_MENU_EDIT_COPY];
    miCut.Caption := _lc[I_MENU_EDIT_CUT];
    miPaste.Caption := _lc[I_MENU_EDIT_PASTE];
    miSelectAll.Caption := _lc[I_MENU_EDIT_SELECT_ALL];
    miToFore.Caption := _lc[I_MENU_EDIT_TO_FORE];
    miToBack.Caption := _lc[I_MENU_EDIT_TO_BACK];
  // "�����������":
    miMenuTools.Caption := _lc[I_MENU_TOOLS];
    miSnapToGrid.Caption := _lc[I_MENU_TOOLS_SNAP_GRID];
    miMiniMap.Caption := _lc[I_MENU_TOOLS_MINIMAP];
    miSwitchGrid.Caption := _lc[I_MENU_TOOLS_STEP_GRID];
    miShowEdges.Caption := _lc[I_MENU_TOOLS_SHOW_EDGES];
    miLayers.Caption := _lc[I_MENU_TOOLS_LAYERS];
    miLayer1.Caption := _lc[I_MENU_LAYER_BACK];
    miLayer2.Caption := _lc[I_MENU_LAYER_WALL];
    miLayer3.Caption := _lc[I_MENU_LAYER_FORE];
    miLayer4.Caption := _lc[I_MENU_LAYER_STAIR];
    miLayer5.Caption := _lc[I_MENU_LAYER_WATER];
    miLayer6.Caption := _lc[I_MENU_LAYER_ITEM];
    miLayer7.Caption := _lc[I_MENU_LAYER_MONSTER];
    miLayer8.Caption := _lc[I_MENU_LAYER_AREA];
    miLayer9.Caption := _lc[I_MENU_LAYER_TRIGGER];
  // "������":
    miMenuService.Caption := _lc[I_MENU_SERV];
    miCheckMap.Caption := _lc[I_MENU_SERV_TEST];
    miOptimmization.Caption := _lc[I_MENU_SERV_OPT];
    miMapPreview.Caption := _lc[I_MENU_SERV_PREVIEW];
    miTestMap.Caption := _lc[I_MENU_SERV_LAUNCH];
  // "���������":
    miMenuSettings.Caption := _lc[I_MENU_SETS];
    miMapOptions.Caption := _lc[I_MENU_SETS_MAP];
    miOptions.Caption := _lc[I_MENU_SETS_EDITOR];
    miMapTestSettings.Caption := _lc[I_MENU_SETS_LAUNCH];
  // "�������":
    miMenuHelp.Caption := _lc[I_MENU_HELP];
    miAbout.Caption := _lc[I_MENU_HELP_ABOUT];

  // ������ ������������:
    tbNewMap.Hint := _lc[I_MENU_TB_NEW];
    tbOpenMap.Hint := _lc[I_MENU_TB_OPEN];
    tbSaveMap.Hint := _lc[I_MENU_TB_SAVE];
    tbOpenWadMap.Hint := _lc[I_MENU_TB_OPEN_WAD];
    tbShowMap.Hint := _lc[I_MENU_TB_MINIMAP];
    tbShow.Hint := _lc[I_MENU_TB_LAYERS];
    tbGridOn.Hint := _lc[I_MENU_TB_GRID];
    tbGrid.Hint := _lc[I_MENU_TB_GRID_STEP];
    tbTestMap.Hint := _lc[I_MENU_TB_LAUNCH];
  // ����������� ���� ��� ������ �����:
    miLayerP1.Caption := _lc[I_MENU_LAYER_BACK];
    miLayerP2.Caption := _lc[I_MENU_LAYER_WALL];
    miLayerP3.Caption := _lc[I_MENU_LAYER_FORE];
    miLayerP4.Caption := _lc[I_MENU_LAYER_STAIR];
    miLayerP5.Caption := _lc[I_MENU_LAYER_WATER];
    miLayerP6.Caption := _lc[I_MENU_LAYER_ITEM];
    miLayerP7.Caption := _lc[I_MENU_LAYER_MONSTER];
    miLayerP8.Caption := _lc[I_MENU_LAYER_AREA];
    miLayerP9.Caption := _lc[I_MENU_LAYER_TRIGGER];
  // ����������� ���� ��� ������ ����� �����:
    miMapTestPMSet.Caption := _lc[I_MENU_LAUNCH_SETS];

  // ������ ���������� �������:
    bApplyProperty.Caption := _lc[I_BTN_APPLY_PROPS];
  // �������� ������� ��������:
    vleObjectProperty.TitleCaptions[0] := _lc[I_CTRL_PROP_KEY];
    vleObjectProperty.TitleCaptions[1] := _lc[I_CTRL_PROP_VALUE];

  // ������� "������":
    tsPanels.Caption := _lc[I_CTRL_PANELS];
    lbPanelType.Hint := _lc[I_PROP_PANEL_TYPE];
    lbTextureList.Hint := _lc[I_CTRL_LIST_TEXTURE];
  // ������ ��������� �������:
    LabelTxW.Caption := _lc[I_LAB_TEX_WIDTH];
    LabelTxH.Caption := _lc[I_LAB_TEX_HEIGHT];
    cbPreview.Caption := _lc[I_CTRL_PREVIEW];
    bbAddTexture.Hint := _lc[I_BTN_TEXTURE_ADD];
    bbRemoveTexture.Hint := _lc[I_BTN_TEXTURE_DELETE];
    bClearTexture.Hint := _lc[I_BTN_TEXTURE_EMPTY];

  // ������� "��������":
    tsItems.Caption := _lc[I_CTRL_ITEMS];
    lbItemList.Hint := _lc[I_CTRL_LIST_ITEM];
    cbOnlyDM.Caption := _lc[I_CTRL_ITEM_DM];
    cbFall.Caption := _lc[I_CTRL_ITEM_FALLS];

  // ������� "�������":
    tsMonsters.Caption := _lc[I_CTRL_MONSTERS];
    lbMonsterList.Hint := _lc[I_CTRL_LIST_MONSTER];
    rbMonsterLeft.Caption := _lc[I_CTRL_LEFT];
    rbMonsterRight.Caption := _lc[I_CTRL_RIGHT];

  // ������� "�������":
    tsAreas.Caption := _lc[I_CTRL_AREAS];
    lbAreasList.Hint := _lc[I_CTRL_LIST_AREA];
    rbAreaLeft.Caption := _lc[I_CTRL_LEFT];
    rbAreaRight.Caption := _lc[I_CTRL_RIGHT];

  // ������� "��������":
    tsTriggers.Caption := _lc[I_CTRL_TRIGGERS];
    lbTriggersList.Hint := _lc[I_CTRL_LIST_TRIGGER];
    clbActivationType.Hint := _lc[I_CTRL_LIST_ACTIVE];
    clbKeys.Hint := _lc[I_CTRL_LIST_KEYS];
  end;

// ����� "� ���������":
  with AboutForm do
  begin
    Caption := _lc[I_CAP_ABOUT];
    LabelTitle.Caption := _lc[I_EDITOR_TITLE];
    LabelVer.Caption := _lc[I_LAB_ABOUT_VER];
    LabelAuthor.Caption := _lc[I_LAB_ABOUT_AUTHOR];
    LabelAuthor2.Caption := _lc[I_LAB_ABOUT_AUTHOR_2];
    LabelMail.Caption := _lc[I_LAB_ABOUT_MAIL];
    LabelMail2.Caption := _lc[I_LAB_ABOUT_MAIL_2];
    LabelSite.Caption := _lc[I_LAB_ABOUT_SITE];
    LabelHttp.Caption := _lc[I_LAB_ABOUT_HTTP];
  end;

// ����� "��� ���������":
  with ActivationTypeForm do
  begin
    Caption := _lc[I_CAP_ACT];
    cbPlayerCollide.Caption := _lc[I_CTRL_ACT_PLAYER_CLOSE];
    cbMonsterCollide.Caption := _lc[I_CTRL_ACT_MONSTER_CLOSE];
    cbPlayerPress.Caption := _lc[I_CTRL_ACT_PLAYER_PRESS];
    cbMonsterPress.Caption := _lc[I_CTRL_ACT_MONSTER_PRESS];
    cbShot.Caption := _lc[I_CTRL_ACT_SHOT];
    cbNoMonster.Caption := _lc[I_CTRL_ACT_NO_MONSTER];
    bOK.Caption := _lc[I_BTN_OK];
  end;

// ����� "����� �������� ��� ����":
  with AddSkyForm do
  begin
    Caption := _lc[I_CAP_ADD_SKY];
    LabelWADs.Caption := _lc[I_LAB_ADD_WADS];
    LabelSections.Caption := _lc[I_LAB_ADD_SECTIONS];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  end;

// ����� "����� ����� ��� ������":
  with AddSoundForm do
  begin
    Caption := _lc[I_CAP_ADD_SOUND];
    LabelWADs.Caption := _lc[I_LAB_ADD_WADS];
    LabelSections.Caption := _lc[I_LAB_ADD_SECTIONS];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
    bEmpty.Caption := _lc[I_BTN_NO_SOUND];
  end;

// ����� "����� ��������":
  with AddTextureForm do
  begin
    Caption := _lc[I_CAP_ADD_TEXTURE];
    LabelWADs.Caption := _lc[I_LAB_ADD_WADS];
    LabelSections.Caption := _lc[I_LAB_ADD_SECTIONS];
    bAddTexture.Caption := _lc[I_BTN_ADD];
    bClose.Caption := _lc[I_BTN_CLOSE];
    bAddClose.Caption := _lc[I_BTN_ADD_CLOSE];
  end;

// ����� "����� ���� �������" / "����� ���� ��������":
  ChooseTypeForm.bOK.Caption := _lc[I_BTN_OK];

// ����� "�����":
  with KeysForm do
  begin
    Caption := _lc[I_CAP_KEYS];
    cbRedKey.Caption := _lc[I_CTRL_KEYS_RED];
    cbGreenKey.Caption := _lc[I_CTRL_KEYS_GREEN];
    cbBlueKey.Caption := _lc[I_CTRL_KEYS_BLUE];
    cbRedTeam.Caption := _lc[I_CTRL_KEYS_TEAM_RED];
    cbBlueTeam.Caption := _lc[I_CTRL_KEYS_TEAM_BLUE];
    bOK.Caption := _lc[I_BTN_OK];
  end;

// ����� "�������� �����":
  with MapCheckForm do
  begin
    Caption := _lc[I_CAP_TEST];
    bCheckMap.Caption := _lc[I_BTN_TEST_AGAIN];
    bClose.Caption := _lc[I_BTN_CLOSE];
  end;

// ����� "����������� �����":
  with MapOptimizationForm do
  begin
    Caption := _lc[I_CAP_OPT];
  // ����� �����������:
    GroupBoxOpt.Caption := _lc[I_CTRL_OPT_GB];
    rbTexturesOptimization.Caption := _lc[I_CTRL_OPT_TEXTURE];
    rbPanelsOptimization.Caption := _lc[I_CTRL_OPT_PANEL];
  // ����������� �������:
    bBeginTextureOptimization.Caption := _lc[I_BTN_START];
  // ����������� �������:
    cbOptimizeWalls.Caption := _lc[I_CTRL_OPT_WALL];
    cbOptimizeForeGround.Caption := _lc[I_CTRL_OPT_FORE];
    cbOptimizeBackGround.Caption := _lc[I_CTRL_OPT_BACK];
    cbOptimizeSteps.Caption := _lc[I_CTRL_OPT_STAIR];
    cbOptimizeWater.Caption := _lc[I_CTRL_OPT_WATER];
    cbOptimizeAcid1.Caption := _lc[I_CTRL_OPT_ACID1];
    cbOptimizeAcid2.Caption := _lc[I_CTRL_OPT_ACID2];
    cbOptimizeLift.Caption := _lc[I_CTRL_OPT_LIFT];
    cbOptimizeBlockMon.Caption := _lc[I_CTRL_OPT_BLOCKMON];
    bBeginPanelsOptimization.Caption := _lc[I_BTN_START];
  end;

// ����� "��������� �����":
  with MapOptionsForm do
  begin
    Caption := _lc[I_CAP_SETS];
  // �������� ���������:
    LabelName.Caption := _lc[I_LAB_SETS_NAME];
    LabelDesc.Caption := _lc[I_LAB_SETS_DESC];
    LabelAuthor.Caption := _lc[I_LAB_SETS_AUTHOR];
    LabelBack.Caption := _lc[I_LAB_SETS_BACK];
    LabelMusic.Caption := _lc[I_LAB_SETS_MUSIC];
  // ����������:
    GBStats.Caption := _lc[I_CTRL_SETS_STATS];
    LabelTexs.Caption := _lc[I_LAB_SETS_TEXTURES];
    LabelPanels.Caption := _lc[I_LAB_SETS_PANELS];
    LabelItems.Caption := _lc[I_LAB_SETS_ITEMS];
    LabelMonsters.Caption := _lc[I_LAB_SETS_MONSTERS];
    LabelAreas.Caption := _lc[I_LAB_SETS_AREAS];
    LabelTriggers.Caption := _lc[I_LAB_SETS_TRIGGERS];
  // �������:
    GBSizes.Caption := _lc[I_CTRL_SETS_SIZES];
    LabelWidth.Caption := _lc[I_LAB_SETS_WIDTH];
    LabelHeight.Caption := _lc[I_LAB_SETS_HEIGHT];
    LabelCurSize.Caption := _lc[I_LAB_SETS_SIZES];
    LabelMapMove.Caption := _lc[I_LAB_SETS_MAPMOVE];
    cbSnapping.Caption := _lc[I_LAB_SETS_SNAPPING];
  // ������:
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  end;

// ����� "��������� ����� �����":
  with MapTestForm do
  begin
    Caption := _lc[I_CAP_LAUNCH];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  // ����� ����:
    rbDM.Caption := _lc[I_CTRL_LAUNCH_DM];
    rbTDM.Caption := _lc[I_CTRL_LAUNCH_TDM];
    rbCTF.Caption := _lc[I_CTRL_LAUNCH_CTF];
    rbCOOP.Caption := _lc[I_CTRL_LAUNCH_COOP];
  // �����:
    cbTwoPlayers.Caption := _lc[I_CTRL_LAUNCH_2P];
    cbTeamDamage.Caption := _lc[I_CTRL_LAUNCH_FF];
    cbAllowExit.Caption := _lc[I_CTRL_LAUNCH_EXIT];
    cbWeaponStay.Caption := _lc[I_CTRL_LAUNCH_WEAPONS];
    cbMonstersDM.Caption := _lc[I_CTRL_LAUNCH_MONSTERS];
    cbMapOnce.Caption := _lc[I_CTRL_LAUNCH_CLOSE];
    LabelTime.Caption := _lc[I_LAB_LAUNCH_TIME];
    LabelSecs.Caption := _lc[I_LAB_LAUNCH_SECS];
    LabelScore.Caption := _lc[I_LAB_LAUNCH_SCORE];
  // ����:
    LabelPath.Caption := _lc[I_LAB_LAUNCH_PATH];
    FindD2dDialog.Title := _lc[I_CTRL_LAUNCH_OPEN];
  end;

// ����� "��������� ���������":
  with OptionsForm do
  begin
    Caption := _lc[I_CAP_ES];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  // ���������:
    cbShowDots.Caption := _lc[I_CTRL_ES_GRID];
    cbShowTexture.Caption := _lc[I_CTRL_ES_TEXTURE];
    cbShowSize.Caption := _lc[I_CTRL_ES_PANEL_SIZE];
    LabelGrid.Caption := _lc[I_LAB_ES_GRID];
    LabelGridCol.Caption := _lc[I_LAB_ES_GRID_COLOR];
    LabelBack.Caption := _lc[I_LAB_ES_BACK];
    LabelPreview.Caption := _lc[I_LAB_ES_PREVIEW];
    LabelMinimap.Caption := _lc[I_LAB_ES_MINIMAP];
    LabelRecent.Caption := _lc[I_LAB_ES_RECENT];
    LabelLanguage.Caption := _lc[I_LAB_ES_LANGUAGE];
  end;

// ����� "��������� �����":
  with PackMapForm do
  begin
    Caption := _lc[I_CAP_PACK];
    bPack.Caption := _lc[I_BTN_PACK];
    LabelSaveTo.Caption := _lc[I_LAB_PACK_SAVE_TO];
    LabelMapName.Caption := _lc[I_LAB_PACK_MAP_NAME];
  // ��� �����������:
    cbTextrures.Caption := _lc[I_CTRL_PACK_TEXTURES];
    LabelTextures.Caption := _lc[I_LAB_PACK_TEXTURES];
    cbSky.Caption := _lc[I_CTRL_PACK_SKY];
    LabelSky.Caption := _lc[I_LAB_PACK_SKY];
    cbMusic.Caption := _lc[I_CTRL_PACK_MUSIC];
    LabelMusic.Caption := _lc[I_LAB_PACK_MUSIC];
    cbAdd.Caption := _lc[I_CTRL_PACK_ADD];
    cbNonStandart.Caption := _lc[I_CTRL_PACK_NON_STD];
  end;

// ����� "��������� �����":
  with SaveMapForm do
  begin
    Caption := _lc[I_CAP_SAVE];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  end;

// ����� "��������� ����-�����":
  with SaveMiniMapForm do
  begin
    Caption := _lc[I_CAP_MINI];
    LabelScale.Caption := _lc[I_LAB_MINI_SCALE];
    bSave.Caption := _lc[I_BTN_SAVE];
    bClose.Caption := _lc[I_BTN_CLOSE];
  end;

// ����� "����� �����":
  with SelectMapForm do
  begin
    Caption := _lc[I_CAP_SELECT];
    bOK.Caption := _lc[I_BTN_OK];
    bCancel.Caption := _lc[I_BTN_CANCEL];
  end;

// ��������� ����������:
  Application.Title := _lc[I_EDITOR_TITLE];
end;

procedure g_Language_Load(fileName: String);
var
  F: TextFile;
  key, value: String;
  i: TStrings_Locale;
  k: Integer;
  ok: Boolean;

begin
// �������� ��-���������:
  for i := Low(TStrings_Locale) to High(TStrings_Locale) do
    _lc[i] := g_lang_default[i][LANGUAGE_ENGLISH_N];

  if FileExists(fileName) then
    begin
      AssignFile(F, fileName);
      ReSet(F);
      k := 0;

    // ������ ����:
      while not EoF(F) do
      begin
      // ������ ������:
        ReadLn(F, key);
        key := Trim(key);

      // ������ - ���� ��������:
        if (key <> '') and
           (key[1] = '[') and
           (Pos(']', key) > 2) then
        begin
          key := UpperCase(Copy(key, 2, Pos(']', key)-2));

        // ���������� ������ ������ �� ������ - ��������:
          value := '';
          while (not EoF(F)) and (value = '') do
          begin
            ReadLn(F, value);
            value := Trim(value);
          end;

        // ���� ������ - �������:
          if value <> '' then
          begin
          // ���� ������ ����� ��������:
            ok := False;
            i := TStrings_Locale(k);

          // �� �������� � �������:
            while i > Low(TStrings_Locale) do
            begin
              if g_lang_default[i][1] = key then
              begin
                _lc[i] := value;
                ok := True;
                Break;
              end;

              Dec(i);
            end;

          // ������:
            if not ok then
            begin
              i := Low(TStrings_Locale);

              if (g_lang_default[i][1] = key) then
              begin
                _lc[i] := value;
                ok := True;
              end;
            end;

          // �� ���������� �� ������� �� ����������:
            if not ok then
            begin
              i := TStrings_Locale(k);

              while i < High(TStrings_Locale) do
              begin
                Inc(i);

                if g_lang_default[i][1] = key then
                begin
                  _lc[i] := value;
                  Break;
                end;
              end;
            end;
          end;

          Inc(k);
        end;
      end;

      CloseFile(F);
    end
  else
    e_WriteLog('Language file "'+fileName+'" not found!', MSG_WARNING);

  SetupArrays();
  SetupCaptions();
  RemoveSelectFromObjects();
end;

procedure g_Language_Set(lang: String);
var
  i: TStrings_Locale;
  n: Byte;

begin
  if lang = LANGUAGE_ENGLISH then
    n := LANGUAGE_ENGLISH_N
  else
    n := LANGUAGE_RUSSIAN_N;

  for i := Low(TStrings_Locale) to High(TStrings_Locale) do
    _lc[i] := g_lang_default[i][n];

  SetupArrays();
  SetupCaptions();
  RemoveSelectFromObjects();
end;

procedure g_Language_Dump(fileName: String);
var
  F: TextFile;
  i: TStrings_Locale;

begin
  AssignFile(F, fileName);
  ReWrite(F);

  for i := Low(TStrings_Locale) to High(TStrings_Locale) do
    WriteLn(F, _lc[i]);

  CloseFile(F);
end;

End.