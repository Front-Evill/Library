local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

math.randomseed(tick())

local Library = {}
Library.__index = Library

local Icons = {
	["lucide-accessibility"] = "rbxassetid://10709751939",
	["lucide-activity"] = "rbxassetid://10709752035",
	["lucide-air-vent"] = "rbxassetid://10709752131",
	["lucide-airplay"] = "rbxassetid://10709752254",
	["lucide-alarm-check"] = "rbxassetid://10709752405",
	["lucide-alarm-clock"] = "rbxassetid://10709752630",
	["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
	["lucide-alarm-minus"] = "rbxassetid://10709752732",
	["lucide-alarm-plus"] = "rbxassetid://10709752825",
	["lucide-album"] = "rbxassetid://10709752906",
	["lucide-alert-circle"] = "rbxassetid://10709752996",
	["lucide-alert-octagon"] = "rbxassetid://10709753064",
	["lucide-alert-triangle"] = "rbxassetid://10709753149",
	["lucide-align-center"] = "rbxassetid://10709753570",
	["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
	["lucide-align-center-vertical"] = "rbxassetid://10709753421",
	["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
	["lucide-align-end-vertical"] = "rbxassetid://10709753808",
	["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
	["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
	["lucide-align-justify"] = "rbxassetid://10709759610",
	["lucide-align-left"] = "rbxassetid://10709759764",
	["lucide-align-right"] = "rbxassetid://10709759895",
	["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
	["lucide-align-start-vertical"] = "rbxassetid://10709760244",
	["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
	["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
	["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
	["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
	["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
	["lucide-anchor"] = "rbxassetid://10709761530",
	["lucide-angry"] = "rbxassetid://10709761629",
	["lucide-annoyed"] = "rbxassetid://10709761722",
	["lucide-aperture"] = "rbxassetid://10709761813",
	["lucide-apple"] = "rbxassetid://10709761889",
	["lucide-archive"] = "rbxassetid://10709762233",
	["lucide-archive-restore"] = "rbxassetid://10709762058",
	["lucide-armchair"] = "rbxassetid://10709762327",
	["lucide-arrow-big-down"] = "rbxassetid://10747796644",
	["lucide-arrow-big-left"] = "rbxassetid://10709762574",
	["lucide-arrow-big-right"] = "rbxassetid://10709762727",
	["lucide-arrow-big-up"] = "rbxassetid://10709762879",
	["lucide-arrow-down"] = "rbxassetid://10709767827",
	["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
	["lucide-arrow-down-left"] = "rbxassetid://10709767656",
	["lucide-arrow-down-right"] = "rbxassetid://10709767750",
	["lucide-arrow-left"] = "rbxassetid://10709768114",
	["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
	["lucide-arrow-left-right"] = "rbxassetid://10709768019",
	["lucide-arrow-right"] = "rbxassetid://10709768347",
	["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
	["lucide-arrow-up"] = "rbxassetid://10709768939",
	["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
	["lucide-arrow-up-down"] = "rbxassetid://10709768538",
	["lucide-arrow-up-left"] = "rbxassetid://10709768661",
	["lucide-arrow-up-right"] = "rbxassetid://10709768787",
	["lucide-asterisk"] = "rbxassetid://10709769095",
	["lucide-at-sign"] = "rbxassetid://10709769286",
	["lucide-award"] = "rbxassetid://10709769406",
	["lucide-axe"] = "rbxassetid://10709769508",
	["lucide-axis-3d"] = "rbxassetid://10709769598",
	["lucide-baby"] = "rbxassetid://10709769732",
	["lucide-backpack"] = "rbxassetid://10709769841",
	["lucide-baggage-claim"] = "rbxassetid://10709769935",
	["lucide-banana"] = "rbxassetid://10709770005",
	["lucide-banknote"] = "rbxassetid://10709770178",
	["lucide-bar-chart"] = "rbxassetid://10709773755",
	["lucide-bar-chart-2"] = "rbxassetid://10709770317",
	["lucide-bar-chart-3"] = "rbxassetid://10709770431",
	["lucide-bar-chart-4"] = "rbxassetid://10709770560",
	["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
	["lucide-barcode"] = "rbxassetid://10747360675",
	["lucide-baseline"] = "rbxassetid://10709773863",
	["lucide-bath"] = "rbxassetid://10709773963",
	["lucide-battery"] = "rbxassetid://10709774640",
	["lucide-battery-charging"] = "rbxassetid://10709774068",
	["lucide-battery-full"] = "rbxassetid://10709774206",
	["lucide-battery-low"] = "rbxassetid://10709774370",
	["lucide-battery-medium"] = "rbxassetid://10709774513",
	["lucide-beaker"] = "rbxassetid://10709774756",
	["lucide-bed"] = "rbxassetid://10709775036",
	["lucide-bed-double"] = "rbxassetid://10709774864",
	["lucide-bed-single"] = "rbxassetid://10709774968",
	["lucide-beer"] = "rbxassetid://10709775167",
	["lucide-bell"] = "rbxassetid://10709775704",
	["lucide-bell-minus"] = "rbxassetid://10709775241",
	["lucide-bell-off"] = "rbxassetid://10709775320",
	["lucide-bell-plus"] = "rbxassetid://10709775448",
	["lucide-bell-ring"] = "rbxassetid://10709775560",
	["lucide-bike"] = "rbxassetid://10709775894",
	["lucide-binary"] = "rbxassetid://10709776050",
	["lucide-bitcoin"] = "rbxassetid://10709776126",
	["lucide-bluetooth"] = "rbxassetid://10709776655",
	["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
	["lucide-bluetooth-off"] = "rbxassetid://10709776344",
	["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
	["lucide-bold"] = "rbxassetid://10747813908",
	["lucide-bomb"] = "rbxassetid://10709781460",
	["lucide-bone"] = "rbxassetid://10709781605",
	["lucide-book"] = "rbxassetid://10709781824",
	["lucide-book-open"] = "rbxassetid://10709781717",
	["lucide-bookmark"] = "rbxassetid://10709782154",
	["lucide-bookmark-minus"] = "rbxassetid://10709781919",
	["lucide-bookmark-plus"] = "rbxassetid://10709782044",
	["lucide-bot"] = "rbxassetid://10709782230",
	["lucide-box"] = "rbxassetid://10709782497",
	["lucide-box-select"] = "rbxassetid://10709782342",
	["lucide-boxes"] = "rbxassetid://10709782582",
	["lucide-briefcase"] = "rbxassetid://10709782662",
	["lucide-brush"] = "rbxassetid://10709782758",
	["lucide-bug"] = "rbxassetid://10709782845",
	["lucide-building"] = "rbxassetid://10709783051",
	["lucide-building-2"] = "rbxassetid://10709782939",
	["lucide-bus"] = "rbxassetid://10709783137",
	["lucide-cake"] = "rbxassetid://10709783217",
	["lucide-calculator"] = "rbxassetid://10709783311",
	["lucide-calendar"] = "rbxassetid://10709789505",
	["lucide-calendar-check"] = "rbxassetid://10709783474",
	["lucide-calendar-check-2"] = "rbxassetid://10709783392",
	["lucide-calendar-clock"] = "rbxassetid://10709783577",
	["lucide-calendar-days"] = "rbxassetid://10709783673",
	["lucide-calendar-heart"] = "rbxassetid://10709783835",
	["lucide-calendar-minus"] = "rbxassetid://10709783959",
	["lucide-calendar-off"] = "rbxassetid://10709788784",
	["lucide-calendar-plus"] = "rbxassetid://10709788937",
	["lucide-calendar-range"] = "rbxassetid://10709789053",
	["lucide-calendar-search"] = "rbxassetid://10709789200",
	["lucide-calendar-x"] = "rbxassetid://10709789407",
	["lucide-calendar-x-2"] = "rbxassetid://10709789329",
	["lucide-camera"] = "rbxassetid://10709789686",
	["lucide-camera-off"] = "rbxassetid://10747822677",
	["lucide-car"] = "rbxassetid://10709789810",
	["lucide-carrot"] = "rbxassetid://10709789960",
	["lucide-cast"] = "rbxassetid://10709790097",
	["lucide-charge"] = "rbxassetid://10709790202",
	["lucide-check"] = "rbxassetid://10709790644",
	["lucide-check-circle"] = "rbxassetid://10709790387",
	["lucide-check-circle-2"] = "rbxassetid://10709790298",
	["lucide-check-square"] = "rbxassetid://10709790537",
	["lucide-chef-hat"] = "rbxassetid://10709790757",
	["lucide-cherry"] = "rbxassetid://10709790875",
	["lucide-chevron-down"] = "rbxassetid://10709790948",
	["lucide-chevron-first"] = "rbxassetid://10709791015",
	["lucide-chevron-last"] = "rbxassetid://10709791130",
	["lucide-chevron-left"] = "rbxassetid://10709791281",
	["lucide-chevron-right"] = "rbxassetid://10709791437",
	["lucide-chevron-up"] = "rbxassetid://10709791523",
	["lucide-chevrons-down"] = "rbxassetid://10709796864",
	["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
	["lucide-chevrons-left"] = "rbxassetid://10709797151",
	["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
	["lucide-chevrons-right"] = "rbxassetid://10709797382",
	["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
	["lucide-chevrons-up"] = "rbxassetid://10709797622",
	["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
	["lucide-chrome"] = "rbxassetid://10709797725",
	["lucide-circle"] = "rbxassetid://10709798174",
	["lucide-circle-dot"] = "rbxassetid://10709797837",
	["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
	["lucide-circle-slashed"] = "rbxassetid://10709798100",
	["lucide-citrus"] = "rbxassetid://10709798276",
	["lucide-clapperboard"] = "rbxassetid://10709798350",
	["lucide-clipboard"] = "rbxassetid://10709799288",
	["lucide-clipboard-check"] = "rbxassetid://10709798443",
	["lucide-clipboard-copy"] = "rbxassetid://10709798574",
	["lucide-clipboard-edit"] = "rbxassetid://10709798682",
	["lucide-clipboard-list"] = "rbxassetid://10709798792",
	["lucide-clipboard-signature"] = "rbxassetid://10709798890",
	["lucide-clipboard-type"] = "rbxassetid://10709798999",
	["lucide-clipboard-x"] = "rbxassetid://10709799124",
	["lucide-clock"] = "rbxassetid://10709805144",
	["lucide-clock-1"] = "rbxassetid://10709799535",
	["lucide-clock-10"] = "rbxassetid://10709799718",
	["lucide-clock-11"] = "rbxassetid://10709799818",
	["lucide-clock-12"] = "rbxassetid://10709799962",
	["lucide-clock-2"] = "rbxassetid://10709803876",
	["lucide-clock-3"] = "rbxassetid://10709803989",
	["lucide-clock-4"] = "rbxassetid://10709804164",
	["lucide-clock-5"] = "rbxassetid://10709804291",
	["lucide-clock-6"] = "rbxassetid://10709804435",
	["lucide-clock-7"] = "rbxassetid://10709804599",
	["lucide-clock-8"] = "rbxassetid://10709804784",
	["lucide-clock-9"] = "rbxassetid://10709804996",
	["lucide-cloud"] = "rbxassetid://10709806740",
	["lucide-cloud-cog"] = "rbxassetid://10709805262",
	["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
	["lucide-cloud-fog"] = "rbxassetid://10709805477",
	["lucide-cloud-hail"] = "rbxassetid://10709805596",
	["lucide-cloud-lightning"] = "rbxassetid://10709805727",
	["lucide-cloud-moon"] = "rbxassetid://10709805942",
	["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
	["lucide-cloud-off"] = "rbxassetid://10709806060",
	["lucide-cloud-rain"] = "rbxassetid://10709806277",
	["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
	["lucide-cloud-snow"] = "rbxassetid://10709806374",
	["lucide-cloud-sun"] = "rbxassetid://10709806631",
	["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
	["lucide-cloudy"] = "rbxassetid://10709806859",
	["lucide-clover"] = "rbxassetid://10709806995",
	["lucide-code"] = "rbxassetid://10709810463",
	["lucide-code-2"] = "rbxassetid://10709807111",
	["lucide-codepen"] = "rbxassetid://10709810534",
	["lucide-codesandbox"] = "rbxassetid://10709810676",
	["lucide-coffee"] = "rbxassetid://10709810814",
	["lucide-cog"] = "rbxassetid://10709810948",
	["lucide-coins"] = "rbxassetid://10709811110",
	["lucide-columns"] = "rbxassetid://10709811261",
	["lucide-command"] = "rbxassetid://10709811365",
	["lucide-compass"] = "rbxassetid://10709811445",
	["lucide-component"] = "rbxassetid://10709811595",
	["lucide-concierge-bell"] = "rbxassetid://10709811706",
	["lucide-connection"] = "rbxassetid://10747361219",
	["lucide-contact"] = "rbxassetid://10709811834",
	["lucide-contrast"] = "rbxassetid://10709811939",
	["lucide-cookie"] = "rbxassetid://10709812067",
	["lucide-copy"] = "rbxassetid://10709812159",
	["lucide-copyleft"] = "rbxassetid://10709812251",
	["lucide-copyright"] = "rbxassetid://10709812311",
	["lucide-corner-down-left"] = "rbxassetid://10709812396",
	["lucide-corner-down-right"] = "rbxassetid://10709812485",
	["lucide-corner-left-down"] = "rbxassetid://10709812632",
	["lucide-corner-left-up"] = "rbxassetid://10709812784",
	["lucide-corner-right-down"] = "rbxassetid://10709812939",
	["lucide-corner-right-up"] = "rbxassetid://10709813094",
	["lucide-corner-up-left"] = "rbxassetid://10709813185",
	["lucide-corner-up-right"] = "rbxassetid://10709813281",
	["lucide-cpu"] = "rbxassetid://10709813383",
	["lucide-croissant"] = "rbxassetid://10709818125",
	["lucide-crop"] = "rbxassetid://10709818245",
	["lucide-cross"] = "rbxassetid://10709818399",
	["lucide-crosshair"] = "rbxassetid://10709818534",
	["lucide-crown"] = "rbxassetid://10709818626",
	["lucide-cup-soda"] = "rbxassetid://10709818763",
	["lucide-curly-braces"] = "rbxassetid://10709818847",
	["lucide-currency"] = "rbxassetid://10709818931",
	["lucide-database"] = "rbxassetid://10709818996",
	["lucide-delete"] = "rbxassetid://10709819059",
	["lucide-diamond"] = "rbxassetid://10709819149",
	["lucide-dice-1"] = "rbxassetid://10709819266",
	["lucide-dice-2"] = "rbxassetid://10709819361",
	["lucide-dice-3"] = "rbxassetid://10709819508",
	["lucide-dice-4"] = "rbxassetid://10709819670",
	["lucide-dice-5"] = "rbxassetid://10709819801",
	["lucide-dice-6"] = "rbxassetid://10709819896",
	["lucide-dices"] = "rbxassetid://10723343321",
	["lucide-diff"] = "rbxassetid://10723343416",
	["lucide-disc"] = "rbxassetid://10723343537",
	["lucide-divide"] = "rbxassetid://10723343805",
	["lucide-divide-circle"] = "rbxassetid://10723343636",
	["lucide-divide-square"] = "rbxassetid://10723343737",
	["lucide-dollar-sign"] = "rbxassetid://10723343958",
	["lucide-download"] = "rbxassetid://10723344270",
	["lucide-download-cloud"] = "rbxassetid://10723344088",
	["lucide-droplet"] = "rbxassetid://10723344432",
	["lucide-droplets"] = "rbxassetid://10734883356",
	["lucide-drumstick"] = "rbxassetid://10723344737",
	["lucide-edit"] = "rbxassetid://10734883598",
	["lucide-edit-2"] = "rbxassetid://10723344885",
	["lucide-edit-3"] = "rbxassetid://10723345088",
	["lucide-egg"] = "rbxassetid://10723345518",
	["lucide-egg-fried"] = "rbxassetid://10723345347",
	["lucide-electricity"] = "rbxassetid://10723345749",
	["lucide-electricity-off"] = "rbxassetid://10723345643",
	["lucide-equal"] = "rbxassetid://10723345990",
	["lucide-equal-not"] = "rbxassetid://10723345866",
	["lucide-eraser"] = "rbxassetid://10723346158",
	["lucide-euro"] = "rbxassetid://10723346372",
	["lucide-expand"] = "rbxassetid://10723346553",
	["lucide-external-link"] = "rbxassetid://10723346684",
	["lucide-eye"] = "rbxassetid://10723346959",
	["lucide-eye-off"] = "rbxassetid://10723346871",
	["lucide-factory"] = "rbxassetid://10723347051",
	["lucide-fan"] = "rbxassetid://10723354359",
	["lucide-fast-forward"] = "rbxassetid://10723354521",
	["lucide-feather"] = "rbxassetid://10723354671",
	["lucide-figma"] = "rbxassetid://10723354801",
	["lucide-file"] = "rbxassetid://10723374641",
	["lucide-file-archive"] = "rbxassetid://10723354921",
	["lucide-file-audio"] = "rbxassetid://10723355148",
	["lucide-file-audio-2"] = "rbxassetid://10723355026",
	["lucide-file-axis-3d"] = "rbxassetid://10723355272",
	["lucide-file-badge"] = "rbxassetid://10723355622",
	["lucide-file-badge-2"] = "rbxassetid://10723355451",
	["lucide-file-bar-chart"] = "rbxassetid://10723355887",
	["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
	["lucide-file-box"] = "rbxassetid://10723355989",
	["lucide-file-check"] = "rbxassetid://10723356210",
	["lucide-file-check-2"] = "rbxassetid://10723356100",
	["lucide-file-clock"] = "rbxassetid://10723356329",
	["lucide-file-code"] = "rbxassetid://10723356507",
	["lucide-file-cog"] = "rbxassetid://10723356830",
	["lucide-file-cog-2"] = "rbxassetid://10723356676",
	["lucide-file-diff"] = "rbxassetid://10723357039",
	["lucide-file-digit"] = "rbxassetid://10723357151",
	["lucide-file-down"] = "rbxassetid://10723357322",
	["lucide-file-edit"] = "rbxassetid://10723357495",
	["lucide-file-heart"] = "rbxassetid://10723357637",
	["lucide-file-image"] = "rbxassetid://10723357790",
	["lucide-file-input"] = "rbxassetid://10723357933",
	["lucide-file-json"] = "rbxassetid://10723364435",
	["lucide-file-json-2"] = "rbxassetid://10723364361",
	["lucide-file-key"] = "rbxassetid://10723364605",
	["lucide-file-key-2"] = "rbxassetid://10723364515",
	["lucide-file-line-chart"] = "rbxassetid://10723364725",
	["lucide-file-lock"] = "rbxassetid://10723364957",
	["lucide-file-lock-2"] = "rbxassetid://10723364861",
	["lucide-file-minus"] = "rbxassetid://10723365254",
	["lucide-file-minus-2"] = "rbxassetid://10723365086",
	["lucide-file-output"] = "rbxassetid://10723365457",
	["lucide-file-pie-chart"] = "rbxassetid://10723365598",
	["lucide-file-plus"] = "rbxassetid://10723365877",
	["lucide-file-plus-2"] = "rbxassetid://10723365766",
	["lucide-file-question"] = "rbxassetid://10723365987",
	["lucide-file-scan"] = "rbxassetid://10723366167",
	["lucide-file-search"] = "rbxassetid://10723366550",
	["lucide-file-search-2"] = "rbxassetid://10723366340",
	["lucide-file-signature"] = "rbxassetid://10723366741",
	["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
	["lucide-file-symlink"] = "rbxassetid://10723367098",
	["lucide-file-terminal"] = "rbxassetid://10723367244",
	["lucide-file-text"] = "rbxassetid://10723367380",
	["lucide-file-type"] = "rbxassetid://10723367606",
	["lucide-file-type-2"] = "rbxassetid://10723367509",
	["lucide-file-up"] = "rbxassetid://10723367734",
	["lucide-file-video"] = "rbxassetid://10723373884",
	["lucide-file-video-2"] = "rbxassetid://10723367834",
	["lucide-file-volume"] = "rbxassetid://10723374172",
	["lucide-file-volume-2"] = "rbxassetid://10723374030",
	["lucide-file-warning"] = "rbxassetid://10723374276",
	["lucide-file-x"] = "rbxassetid://10723374544",
	["lucide-file-x-2"] = "rbxassetid://10723374378",
	["lucide-files"] = "rbxassetid://10723374759",
	["lucide-film"] = "rbxassetid://10723374981",
	["lucide-filter"] = "rbxassetid://10723375128",
	["lucide-fingerprint"] = "rbxassetid://10723375250",
	["lucide-flag"] = "rbxassetid://10723375890",
	["lucide-flag-off"] = "rbxassetid://10723375443",
	["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
	["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
	["lucide-flame"] = "rbxassetid://10723376114",
	["lucide-flashlight"] = "rbxassetid://10723376471",
	["lucide-flashlight-off"] = "rbxassetid://10723376365",
	["lucide-flask-conical"] = "rbxassetid://10734883986",
	["lucide-flask-round"] = "rbxassetid://10723376614",
	["lucide-flip-horizontal"] = "rbxassetid://10723376884",
	["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
	["lucide-flip-vertical"] = "rbxassetid://10723377138",
	["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
	["lucide-flower"] = "rbxassetid://10747830374",
	["lucide-flower-2"] = "rbxassetid://10723377305",
	["lucide-focus"] = "rbxassetid://10723377537",
	["lucide-folder"] = "rbxassetid://10723387563",
	["lucide-folder-archive"] = "rbxassetid://10723384478",
	["lucide-folder-check"] = "rbxassetid://10723384605",
	["lucide-folder-clock"] = "rbxassetid://10723384731",
	["lucide-folder-closed"] = "rbxassetid://10723384893",
	["lucide-folder-cog"] = "rbxassetid://10723385213",
	["lucide-folder-cog-2"] = "rbxassetid://10723385036",
	["lucide-folder-down"] = "rbxassetid://10723385338",
	["lucide-folder-edit"] = "rbxassetid://10723385445",
	["lucide-folder-heart"] = "rbxassetid://10723385545",
	["lucide-folder-input"] = "rbxassetid://10723385721",
	["lucide-folder-key"] = "rbxassetid://10723385848",
	["lucide-folder-lock"] = "rbxassetid://10723386005",
	["lucide-folder-minus"] = "rbxassetid://10723386127",
	["lucide-folder-open"] = "rbxassetid://10723386277",
	["lucide-folder-output"] = "rbxassetid://10723386386",
	["lucide-folder-plus"] = "rbxassetid://10723386531",
	["lucide-folder-search"] = "rbxassetid://10723386787",
	["lucide-folder-search-2"] = "rbxassetid://10723386674",
	["lucide-folder-symlink"] = "rbxassetid://10723386930",
	["lucide-folder-tree"] = "rbxassetid://10723387085",
	["lucide-folder-up"] = "rbxassetid://10723387265",
	["lucide-folder-x"] = "rbxassetid://10723387448",
	["lucide-folders"] = "rbxassetid://10723387721",
	["lucide-form-input"] = "rbxassetid://10723387841",
	["lucide-forward"] = "rbxassetid://10723388016",
	["lucide-frame"] = "rbxassetid://10723394389",
	["lucide-framer"] = "rbxassetid://10723394565",
	["lucide-frown"] = "rbxassetid://10723394681",
	["lucide-fuel"] = "rbxassetid://10723394846",
	["lucide-function-square"] = "rbxassetid://10723395041",
	["lucide-gamepad"] = "rbxassetid://10723395457",
	["lucide-gamepad-2"] = "rbxassetid://10723395215",
	["lucide-gauge"] = "rbxassetid://10723395708",
	["lucide-gavel"] = "rbxassetid://10723395896",
	["lucide-gem"] = "rbxassetid://10723396000",
	["lucide-ghost"] = "rbxassetid://10723396107",
	["lucide-gift"] = "rbxassetid://10723396402",
	["lucide-gift-card"] = "rbxassetid://10723396225",
	["lucide-git-branch"] = "rbxassetid://10723396676",
	["lucide-git-branch-plus"] = "rbxassetid://10723396542",
	["lucide-git-commit"] = "rbxassetid://10723396812",
	["lucide-git-compare"] = "rbxassetid://10723396954",
	["lucide-git-fork"] = "rbxassetid://10723397049",
	["lucide-git-merge"] = "rbxassetid://10723397165",
	["lucide-git-pull-request"] = "rbxassetid://10723397431",
	["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
	["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
	["lucide-glass"] = "rbxassetid://10723397788",
	["lucide-glass-2"] = "rbxassetid://10723397529",
	["lucide-glass-water"] = "rbxassetid://10723397678",
	["lucide-glasses"] = "rbxassetid://10723397895",
	["lucide-globe"] = "rbxassetid://10723404337",
	["lucide-globe-2"] = "rbxassetid://10723398002",
	["lucide-grab"] = "rbxassetid://10723404472",
	["lucide-graduation-cap"] = "rbxassetid://10723404691",
	["lucide-grape"] = "rbxassetid://10723404822",
	["lucide-grid"] = "rbxassetid://10723404936",
	["lucide-grip-horizontal"] = "rbxassetid://10723405089",
	["lucide-grip-vertical"] = "rbxassetid://10723405236",
	["lucide-hammer"] = "rbxassetid://10723405360",
	["lucide-hand"] = "rbxassetid://10723405649",
	["lucide-hand-metal"] = "rbxassetid://10723405508",
	["lucide-hard-drive"] = "rbxassetid://10723405749",
	["lucide-hard-hat"] = "rbxassetid://10723405859",
	["lucide-hash"] = "rbxassetid://10723405975",
	["lucide-haze"] = "rbxassetid://10723406078",
	["lucide-headphones"] = "rbxassetid://10723406165",
	["lucide-heart"] = "rbxassetid://10723406885",
	["lucide-heart-crack"] = "rbxassetid://10723406299",
	["lucide-heart-handshake"] = "rbxassetid://10723406480",
	["lucide-heart-off"] = "rbxassetid://10723406662",
	["lucide-heart-pulse"] = "rbxassetid://10723406795",
	["lucide-help-circle"] = "rbxassetid://10723406988",
	["lucide-hexagon"] = "rbxassetid://10723407092",
	["lucide-highlighter"] = "rbxassetid://10723407192",
	["lucide-history"] = "rbxassetid://10723407335",
	["lucide-home"] = "rbxassetid://10723407389",
	["lucide-hourglass"] = "rbxassetid://10723407498",
	["lucide-ice-cream"] = "rbxassetid://10723414308",
	["lucide-image"] = "rbxassetid://10723415040",
	["lucide-image-minus"] = "rbxassetid://10723414487",
	["lucide-image-off"] = "rbxassetid://10723414677",
	["lucide-image-plus"] = "rbxassetid://10723414827",
	["lucide-import"] = "rbxassetid://10723415205",
	["lucide-inbox"] = "rbxassetid://10723415335",
	["lucide-indent"] = "rbxassetid://10723415494",
	["lucide-indian-rupee"] = "rbxassetid://10723415642",
	["lucide-infinity"] = "rbxassetid://10723415766",
	["lucide-info"] = "rbxassetid://10723415903",
	["lucide-inspect"] = "rbxassetid://10723416057",
	["lucide-italic"] = "rbxassetid://10723416195",
	["lucide-japanese-yen"] = "rbxassetid://10723416363",
	["lucide-joystick"] = "rbxassetid://10723416527",
	["lucide-key"] = "rbxassetid://10723416652",
	["lucide-keyboard"] = "rbxassetid://10723416765",
	["lucide-lamp"] = "rbxassetid://10723417513",
	["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
	["lucide-lamp-desk"] = "rbxassetid://10723417016",
	["lucide-lamp-floor"] = "rbxassetid://10723417131",
	["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
	["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
	["lucide-landmark"] = "rbxassetid://10723417608",
	["lucide-languages"] = "rbxassetid://10723417703",
	["lucide-laptop"] = "rbxassetid://10723423881",
	["lucide-laptop-2"] = "rbxassetid://10723417797",
	["lucide-lasso"] = "rbxassetid://10723424235",
	["lucide-lasso-select"] = "rbxassetid://10723424058",
	["lucide-laugh"] = "rbxassetid://10723424372",
	["lucide-layers"] = "rbxassetid://10723424505",
	["lucide-layout"] = "rbxassetid://10723425376",
	["lucide-layout-dashboard"] = "rbxassetid://10723424646",
	["lucide-layout-grid"] = "rbxassetid://10723424838",
	["lucide-layout-list"] = "rbxassetid://10723424963",
	["lucide-layout-template"] = "rbxassetid://10723425187",
	["lucide-leaf"] = "rbxassetid://10723425539",
	["lucide-library"] = "rbxassetid://10723425615",
	["lucide-life-buoy"] = "rbxassetid://10723425685",
	["lucide-lightbulb"] = "rbxassetid://10723425852",
	["lucide-lightbulb-off"] = "rbxassetid://10723425762",
	["lucide-line-chart"] = "rbxassetid://10723426393",
	["lucide-link"] = "rbxassetid://10723426722",
	["lucide-link-2"] = "rbxassetid://10723426595",
	["lucide-link-2-off"] = "rbxassetid://10723426513",
	["lucide-list"] = "rbxassetid://10723433811",
	["lucide-list-checks"] = "rbxassetid://10734884548",
	["lucide-list-end"] = "rbxassetid://10723426886",
	["lucide-list-minus"] = "rbxassetid://10723426986",
	["lucide-list-music"] = "rbxassetid://10723427081",
	["lucide-list-ordered"] = "rbxassetid://10723427199",
	["lucide-list-plus"] = "rbxassetid://10723427334",
	["lucide-list-start"] = "rbxassetid://10723427494",
	["lucide-list-video"] = "rbxassetid://10723427619",
	["lucide-list-x"] = "rbxassetid://10723433655",
	["lucide-loader"] = "rbxassetid://10723434070",
	["lucide-loader-2"] = "rbxassetid://10723433935",
	["lucide-locate"] = "rbxassetid://10723434557",
	["lucide-locate-fixed"] = "rbxassetid://10723434236",
	["lucide-locate-off"] = "rbxassetid://10723434379",
	["lucide-lock"] = "rbxassetid://10723434711",
	["lucide-log-in"] = "rbxassetid://10723434830",
	["lucide-log-out"] = "rbxassetid://10723434906",
	["lucide-luggage"] = "rbxassetid://10723434993",
	["lucide-magnet"] = "rbxassetid://10723435069",
	["lucide-mail"] = "rbxassetid://10734885430",
	["lucide-mail-check"] = "rbxassetid://10723435182",
	["lucide-mail-minus"] = "rbxassetid://10723435261",
	["lucide-mail-open"] = "rbxassetid://10723435342",
	["lucide-mail-plus"] = "rbxassetid://10723435443",
	["lucide-mail-question"] = "rbxassetid://10723435515",
	["lucide-mail-search"] = "rbxassetid://10734884739",
	["lucide-mail-warning"] = "rbxassetid://10734885015",
	["lucide-mail-x"] = "rbxassetid://10734885247",
	["lucide-mails"] = "rbxassetid://10734885614",
	["lucide-map"] = "rbxassetid://10734886202",
	["lucide-map-pin"] = "rbxassetid://10734886004",
	["lucide-map-pin-off"] = "rbxassetid://10734885803",
	["lucide-maximize"] = "rbxassetid://10734886735",
	["lucide-maximize-2"] = "rbxassetid://10734886496",
	["lucide-medal"] = "rbxassetid://10734887072",
	["lucide-megaphone"] = "rbxassetid://10734887454",
	["lucide-megaphone-off"] = "rbxassetid://10734887311",
	["lucide-meh"] = "rbxassetid://10734887603",
	["lucide-menu"] = "rbxassetid://10734887784",
	["lucide-message-circle"] = "rbxassetid://10734888000",
	["lucide-message-square"] = "rbxassetid://10734888228",
	["lucide-mic"] = "rbxassetid://10734888864",
	["lucide-mic-2"] = "rbxassetid://10734888430",
	["lucide-mic-off"] = "rbxassetid://10734888646",
	["lucide-microscope"] = "rbxassetid://10734889106",
	["lucide-microwave"] = "rbxassetid://10734895076",
	["lucide-milestone"] = "rbxassetid://10734895310",
	["lucide-minimize"] = "rbxassetid://10734895698",
	["lucide-minimize-2"] = "rbxassetid://10734895530",
	["lucide-minus"] = "rbxassetid://10734896206",
	["lucide-minus-circle"] = "rbxassetid://10734895856",
	["lucide-minus-square"] = "rbxassetid://10734896029",
	["lucide-monitor"] = "rbxassetid://10734896881",
	["lucide-monitor-off"] = "rbxassetid://10734896360",
	["lucide-monitor-speaker"] = "rbxassetid://10734896512",
	["lucide-moon"] = "rbxassetid://10734897102",
	["lucide-more-horizontal"] = "rbxassetid://10734897250",
	["lucide-more-vertical"] = "rbxassetid://10734897387",
	["lucide-mountain"] = "rbxassetid://10734897956",
	["lucide-mountain-snow"] = "rbxassetid://10734897665",
	["lucide-mouse"] = "rbxassetid://10734898592",
	["lucide-mouse-pointer"] = "rbxassetid://10734898476",
	["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
	["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
	["lucide-move"] = "rbxassetid://10734900011",
	["lucide-move-3d"] = "rbxassetid://10734898756",
	["lucide-move-diagonal"] = "rbxassetid://10734899164",
	["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
	["lucide-move-horizontal"] = "rbxassetid://10734899414",
	["lucide-move-vertical"] = "rbxassetid://10734899821",
	["lucide-music"] = "rbxassetid://10734905958",
	["lucide-music-2"] = "rbxassetid://10734900215",
	["lucide-music-3"] = "rbxassetid://10734905665",
	["lucide-music-4"] = "rbxassetid://10734905823",
	["lucide-navigation"] = "rbxassetid://10734906744",
	["lucide-navigation-2"] = "rbxassetid://10734906332",
	["lucide-navigation-2-off"] = "rbxassetid://10734906144",
	["lucide-navigation-off"] = "rbxassetid://10734906580",
	["lucide-network"] = "rbxassetid://10734906975",
	["lucide-newspaper"] = "rbxassetid://10734907168",
	["lucide-octagon"] = "rbxassetid://10734907361",
	["lucide-option"] = "rbxassetid://10734907649",
	["lucide-outdent"] = "rbxassetid://10734907933",
	["lucide-package"] = "rbxassetid://10734909540",
	["lucide-package-2"] = "rbxassetid://10734908151",
	["lucide-package-check"] = "rbxassetid://10734908384",
	["lucide-package-minus"] = "rbxassetid://10734908626",
	["lucide-package-open"] = "rbxassetid://10734908793",
	["lucide-package-plus"] = "rbxassetid://10734909016",
	["lucide-package-search"] = "rbxassetid://10734909196",
	["lucide-package-x"] = "rbxassetid://10734909375",
	["lucide-paint-bucket"] = "rbxassetid://10734909847",
	["lucide-paintbrush"] = "rbxassetid://10734910187",
	["lucide-paintbrush-2"] = "rbxassetid://10734910030",
	["lucide-palette"] = "rbxassetid://10734910430",
	["lucide-palmtree"] = "rbxassetid://10734910680",
	["lucide-paperclip"] = "rbxassetid://10734910927",
	["lucide-party-popper"] = "rbxassetid://10734918735",
	["lucide-pause"] = "rbxassetid://10734919336",
	["lucide-pause-circle"] = "rbxassetid://10735024209",
	["lucide-pause-octagon"] = "rbxassetid://10734919143",
	["lucide-pen-tool"] = "rbxassetid://10734919503",
	["lucide-pencil"] = "rbxassetid://10734919691",
	["lucide-percent"] = "rbxassetid://10734919919",
	["lucide-person-standing"] = "rbxassetid://10734920149",
	["lucide-phone"] = "rbxassetid://10734921524",
	["lucide-phone-call"] = "rbxassetid://10734920305",
	["lucide-phone-forwarded"] = "rbxassetid://10734920508",
	["lucide-phone-incoming"] = "rbxassetid://10734920694",
	["lucide-phone-missed"] = "rbxassetid://10734920845",
	["lucide-phone-off"] = "rbxassetid://10734921077",
	["lucide-phone-outgoing"] = "rbxassetid://10734921288",
	["lucide-pie-chart"] = "rbxassetid://10734921727",
	["lucide-piggy-bank"] = "rbxassetid://10734921935",
	["lucide-pin"] = "rbxassetid://10734922324",
	["lucide-pin-off"] = "rbxassetid://10734922180",
	["lucide-pipette"] = "rbxassetid://10734922497",
	["lucide-pizza"] = "rbxassetid://10734922774",
	["lucide-plane"] = "rbxassetid://10734922971",
	["lucide-play"] = "rbxassetid://10734923549",
	["lucide-play-circle"] = "rbxassetid://10734923214",
	["lucide-plus"] = "rbxassetid://10734924532",
	["lucide-plus-circle"] = "rbxassetid://10734923868",
	["lucide-plus-square"] = "rbxassetid://10734924219",
	["lucide-podcast"] = "rbxassetid://10734929553",
	["lucide-pointer"] = "rbxassetid://10734929723",
	["lucide-pound-sterling"] = "rbxassetid://10734929981",
	["lucide-power"] = "rbxassetid://10734930466",
	["lucide-power-off"] = "rbxassetid://10734930257",
	["lucide-printer"] = "rbxassetid://10734930632",
	["lucide-puzzle"] = "rbxassetid://10734930886",
	["lucide-quote"] = "rbxassetid://10734931234",
	["lucide-radio"] = "rbxassetid://10734931596",
	["lucide-radio-receiver"] = "rbxassetid://10734931402",
	["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
	["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
	["lucide-recycle"] = "rbxassetid://10734932295",
	["lucide-redo"] = "rbxassetid://10734932822",
	["lucide-redo-2"] = "rbxassetid://10734932586",
	["lucide-refresh-ccw"] = "rbxassetid://10734933056",
	["lucide-refresh-cw"] = "rbxassetid://10734933222",
	["lucide-refrigerator"] = "rbxassetid://10734933465",
	["lucide-regex"] = "rbxassetid://10734933655",
	["lucide-repeat"] = "rbxassetid://10734933966",
	["lucide-repeat-1"] = "rbxassetid://10734933826",
	["lucide-reply"] = "rbxassetid://10734934252",
	["lucide-reply-all"] = "rbxassetid://10734934132",
	["lucide-rewind"] = "rbxassetid://10734934347",
	["lucide-rocket"] = "rbxassetid://10734934585",
	["lucide-rocking-chair"] = "rbxassetid://10734939942",
	["lucide-rotate-3d"] = "rbxassetid://10734940107",
	["lucide-rotate-ccw"] = "rbxassetid://10734940376",
	["lucide-rotate-cw"] = "rbxassetid://10734940654",
	["lucide-rss"] = "rbxassetid://10734940825",
	["lucide-ruler"] = "rbxassetid://10734941018",
	["lucide-russian-ruble"] = "rbxassetid://10734941199",
	["lucide-sailboat"] = "rbxassetid://10734941354",
	["lucide-save"] = "rbxassetid://10734941499",
	["lucide-scale"] = "rbxassetid://10734941912",
	["lucide-scale-3d"] = "rbxassetid://10734941739",
	["lucide-scaling"] = "rbxassetid://10734942072",
	["lucide-scan"] = "rbxassetid://10734942565",
	["lucide-scan-face"] = "rbxassetid://10734942198",
	["lucide-scan-line"] = "rbxassetid://10734942351",
	["lucide-scissors"] = "rbxassetid://10734942778",
	["lucide-screen-share"] = "rbxassetid://10734943193",
	["lucide-screen-share-off"] = "rbxassetid://10734942967",
	["lucide-scroll"] = "rbxassetid://10734943448",
	["lucide-search"] = "rbxassetid://10734943674",
	["lucide-send"] = "rbxassetid://10734943902",
	["lucide-separator-horizontal"] = "rbxassetid://10734944115",
	["lucide-separator-vertical"] = "rbxassetid://10734944326",
	["lucide-server"] = "rbxassetid://10734949856",
	["lucide-server-cog"] = "rbxassetid://10734944444",
	["lucide-server-crash"] = "rbxassetid://10734944554",
	["lucide-server-off"] = "rbxassetid://10734944668",
	["lucide-settings"] = "rbxassetid://10734950309",
	["lucide-settings-2"] = "rbxassetid://10734950020",
	["lucide-share"] = "rbxassetid://10734950813",
	["lucide-share-2"] = "rbxassetid://10734950553",
	["lucide-sheet"] = "rbxassetid://10734951038",
	["lucide-shield"] = "rbxassetid://10734951847",
	["lucide-shield-alert"] = "rbxassetid://10734951173",
	["lucide-shield-check"] = "rbxassetid://10734951367",
	["lucide-shield-close"] = "rbxassetid://10734951535",
	["lucide-shield-off"] = "rbxassetid://10734951684",
	["lucide-shirt"] = "rbxassetid://10734952036",
	["lucide-shopping-bag"] = "rbxassetid://10734952273",
	["lucide-shopping-cart"] = "rbxassetid://10734952479",
	["lucide-shovel"] = "rbxassetid://10734952773",
	["lucide-shower-head"] = "rbxassetid://10734952942",
	["lucide-shrink"] = "rbxassetid://10734953073",
	["lucide-shrub"] = "rbxassetid://10734953241",
	["lucide-shuffle"] = "rbxassetid://10734953451",
	["lucide-sidebar"] = "rbxassetid://10734954301",
	["lucide-sidebar-close"] = "rbxassetid://10734953715",
	["lucide-sidebar-open"] = "rbxassetid://10734954000",
	["lucide-sigma"] = "rbxassetid://10734954538",
	["lucide-signal"] = "rbxassetid://10734961133",
	["lucide-signal-high"] = "rbxassetid://10734954807",
	["lucide-signal-low"] = "rbxassetid://10734955080",
	["lucide-signal-medium"] = "rbxassetid://10734955336",
	["lucide-signal-zero"] = "rbxassetid://10734960878",
	["lucide-siren"] = "rbxassetid://10734961284",
	["lucide-skip-back"] = "rbxassetid://10734961526",
	["lucide-skip-forward"] = "rbxassetid://10734961809",
	["lucide-skull"] = "rbxassetid://10734962068",
	["lucide-slack"] = "rbxassetid://10734962339",
	["lucide-slash"] = "rbxassetid://10734962600",
	["lucide-slice"] = "rbxassetid://10734963024",
	["lucide-sliders"] = "rbxassetid://10734963400",
	["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
	["lucide-smartphone"] = "rbxassetid://10734963940",
	["lucide-smartphone-charging"] = "rbxassetid://10734963671",
	["lucide-smile"] = "rbxassetid://10734964441",
	["lucide-smile-plus"] = "rbxassetid://10734964188",
	["lucide-snowflake"] = "rbxassetid://10734964600",
	["lucide-sofa"] = "rbxassetid://10734964852",
	["lucide-sort-asc"] = "rbxassetid://10734965115",
	["lucide-sort-desc"] = "rbxassetid://10734965287",
	["lucide-speaker"] = "rbxassetid://10734965419",
	["lucide-sprout"] = "rbxassetid://10734965572",
	["lucide-square"] = "rbxassetid://10734965702",
	["lucide-star"] = "rbxassetid://10734966248",
	["lucide-star-half"] = "rbxassetid://10734965897",
	["lucide-star-off"] = "rbxassetid://10734966097",
	["lucide-stethoscope"] = "rbxassetid://10734966384",
	["lucide-sticker"] = "rbxassetid://10734972234",
	["lucide-sticky-note"] = "rbxassetid://10734972463",
	["lucide-stop-circle"] = "rbxassetid://10734972621",
	["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
	["lucide-stretch-vertical"] = "rbxassetid://10734973130",
	["lucide-strikethrough"] = "rbxassetid://10734973290",
	["lucide-subscript"] = "rbxassetid://10734973457",
	["lucide-sun"] = "rbxassetid://10734974297",
	["lucide-sun-dim"] = "rbxassetid://10734973645",
	["lucide-sun-medium"] = "rbxassetid://10734973778",
	["lucide-sun-moon"] = "rbxassetid://10734973999",
	["lucide-sun-snow"] = "rbxassetid://10734974130",
	["lucide-sunrise"] = "rbxassetid://10734974522",
	["lucide-sunset"] = "rbxassetid://10734974689",
	["lucide-superscript"] = "rbxassetid://10734974850",
	["lucide-swiss-franc"] = "rbxassetid://10734975024",
	["lucide-switch-camera"] = "rbxassetid://10734975214",
	["lucide-sword"] = "rbxassetid://10734975486",
	["lucide-swords"] = "rbxassetid://10734975692",
	["lucide-syringe"] = "rbxassetid://10734975932",
	["lucide-table"] = "rbxassetid://10734976230",
	["lucide-table-2"] = "rbxassetid://10734976097",
	["lucide-tablet"] = "rbxassetid://10734976394",
	["lucide-tag"] = "rbxassetid://10734976528",
	["lucide-tags"] = "rbxassetid://10734976739",
	["lucide-target"] = "rbxassetid://10734977012",
	["lucide-tent"] = "rbxassetid://10734981750",
	["lucide-terminal"] = "rbxassetid://10734982144",
	["lucide-terminal-square"] = "rbxassetid://10734981995",
	["lucide-text-cursor"] = "rbxassetid://10734982395",
	["lucide-text-cursor-input"] = "rbxassetid://10734982297",
	["lucide-thermometer"] = "rbxassetid://10734983134",
	["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
	["lucide-thermometer-sun"] = "rbxassetid://10734982771",
	["lucide-thumbs-down"] = "rbxassetid://10734983359",
	["lucide-thumbs-up"] = "rbxassetid://10734983629",
	["lucide-ticket"] = "rbxassetid://10734983868",
	["lucide-timer"] = "rbxassetid://10734984606",
	["lucide-timer-off"] = "rbxassetid://10734984138",
	["lucide-timer-reset"] = "rbxassetid://10734984355",
	["lucide-toggle-left"] = "rbxassetid://10734984834",
	["lucide-toggle-right"] = "rbxassetid://10734985040",
	["lucide-tornado"] = "rbxassetid://10734985247",
	["lucide-toy-brick"] = "rbxassetid://10747361919",
	["lucide-train"] = "rbxassetid://10747362105",
	["lucide-trash"] = "rbxassetid://10747362393",
	["lucide-trash-2"] = "rbxassetid://10747362241",
	["lucide-tree-deciduous"] = "rbxassetid://10747362534",
	["lucide-tree-pine"] = "rbxassetid://10747362748",
	["lucide-trees"] = "rbxassetid://10747363016",
	["lucide-trending-down"] = "rbxassetid://10747363205",
	["lucide-trending-up"] = "rbxassetid://10747363465",
	["lucide-triangle"] = "rbxassetid://10747363621",
	["lucide-trophy"] = "rbxassetid://10747363809",
	["lucide-truck"] = "rbxassetid://10747364031",
	["lucide-tv"] = "rbxassetid://10747364593",
	["lucide-tv-2"] = "rbxassetid://10747364302",
	["lucide-type"] = "rbxassetid://10747364761",
	["lucide-umbrella"] = "rbxassetid://10747364971",
	["lucide-underline"] = "rbxassetid://10747365191",
	["lucide-undo"] = "rbxassetid://10747365484",
	["lucide-undo-2"] = "rbxassetid://10747365359",
	["lucide-unlink"] = "rbxassetid://10747365771",
	["lucide-unlink-2"] = "rbxassetid://10747397871",
	["lucide-unlock"] = "rbxassetid://10747366027",
	["lucide-upload"] = "rbxassetid://10747366434",
	["lucide-upload-cloud"] = "rbxassetid://10747366266",
	["lucide-usb"] = "rbxassetid://10747366606",
	["lucide-user"] = "rbxassetid://10747373176",
	["lucide-user-check"] = "rbxassetid://10747371901",
	["lucide-user-cog"] = "rbxassetid://10747372167",
	["lucide-user-minus"] = "rbxassetid://10747372346",
	["lucide-user-plus"] = "rbxassetid://10747372702",
	["lucide-user-x"] = "rbxassetid://10747372992",
	["lucide-users"] = "rbxassetid://10747373426",
	["lucide-utensils"] = "rbxassetid://10747373821",
	["lucide-utensils-crossed"] = "rbxassetid://10747373629",
	["lucide-venetian-mask"] = "rbxassetid://10747374003",
	["lucide-verified"] = "rbxassetid://10747374131",
	["lucide-vibrate"] = "rbxassetid://10747374489",
	["lucide-vibrate-off"] = "rbxassetid://10747374269",
	["lucide-video"] = "rbxassetid://10747374938",
	["lucide-video-off"] = "rbxassetid://10747374721",
	["lucide-view"] = "rbxassetid://10747375132",
	["lucide-voicemail"] = "rbxassetid://10747375281",
	["lucide-volume"] = "rbxassetid://10747376008",
	["lucide-volume-1"] = "rbxassetid://10747375450",
	["lucide-volume-2"] = "rbxassetid://10747375679",
	["lucide-volume-x"] = "rbxassetid://10747375880",
	["lucide-wallet"] = "rbxassetid://10747376205",
	["lucide-wand"] = "rbxassetid://10747376565",
	["lucide-wand-2"] = "rbxassetid://10747376349",
	["lucide-watch"] = "rbxassetid://10747376722",
	["lucide-waves"] = "rbxassetid://10747376931",
	["lucide-webcam"] = "rbxassetid://10747381992",
	["lucide-wifi"] = "rbxassetid://10747382504",
	["lucide-wifi-off"] = "rbxassetid://10747382268",
	["lucide-wind"] = "rbxassetid://10747382750",
	["lucide-wrap-text"] = "rbxassetid://10747383065",
	["lucide-wrench"] = "rbxassetid://10747383470",
	["lucide-x"] = "rbxassetid://10747384394",
	["lucide-x-circle"] = "rbxassetid://10747383819",
	["lucide-x-octagon"] = "rbxassetid://10747384037",
	["lucide-x-square"] = "rbxassetid://10747384217",
	["lucide-zoom-in"] = "rbxassetid://10747384552",
	["lucide-zoom-out"] = "rbxassetid://10747384679",
}

local function ResolveIcon(name)
	if not name or name == "" then
		return ""
	end

	if typeof(name) == "number" then
		return "rbxassetid://" .. tostring(name)
	end

	if name:sub(1, 12) == "rbxassetid:/" then
		return name
	end

	local key = name
	if key:sub(1, 7) ~= "lucide-" then
		key = "lucide-" .. key
	end

	return Icons[key] or Icons["lucide-circle"]
end

local ActiveAcrylicCount = 0

local function EnableAcrylicLighting()
	ActiveAcrylicCount = ActiveAcrylicCount + 1

	local existing = Lighting:FindFirstChild("VantaAcrylicDOF")
	if existing then
		return
	end

	local dof = Instance.new("DepthOfFieldEffect")
	dof.Name = "VantaAcrylicDOF"
	dof.FarIntensity = 1
	dof.NearIntensity = 1
	dof.InFocusRadius = 0.05
	dof.FocusDistance = 0.05
	dof.Parent = Lighting
end

local function DisableAcrylicLighting()
	ActiveAcrylicCount = math.max(0, ActiveAcrylicCount - 1)

	if ActiveAcrylicCount == 0 then
		local existing = Lighting:FindFirstChild("VantaAcrylicDOF")
		if existing then
			existing:Destroy()
		end
	end
end

local function CreateGlassPart()
	local part = Instance.new("Part")
	part.Name = "VantaGlass"
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CastShadow = false
	part.Locked = true
	part.Material = Enum.Material.SmoothPlastic
	part.Reflectance = 0
	part.Color = Color3.new(0, 0, 0)
	part.Transparency = 0.98
	part.Size = Vector3.new(1, 1, 0)

	local mesh = Instance.new("SpecialMesh")
	mesh.MeshType = Enum.MeshType.Brick
	mesh.Offset = Vector3.new(0, 0, -0.0001)
	mesh.Parent = part

	return part, mesh
end

local function AttachAcrylicGlass(frame, screenGui)
	local camera = Workspace.CurrentCamera
	if not camera then
		return nil
	end

	local part, mesh = CreateGlassPart()
	part.Parent = camera

	local distance = 0.05
	local inset = 3
	local connections = {}
	local running = true

	local function project(point2D)
		local cam = Workspace.CurrentCamera
		if not cam then
			return Vector3.new()
		end
		local ray = cam:ScreenPointToRay(point2D.X, point2D.Y)
		return ray.Origin + ray.Direction * distance
	end

	local function update()
		if not running then
			return
		end

		local cam = Workspace.CurrentCamera
		if not cam or not part.Parent then
			return
		end

		local ok = pcall(function()
			local absPos = frame.AbsolutePosition
			local absSize = frame.AbsoluteSize

			local topLeft = absPos + Vector2.new(inset, inset)
			local topRight = topLeft + Vector2.new(math.max(absSize.X - inset * 2, 1), 0)
			local bottomRight = topLeft + Vector2.new(math.max(absSize.X - inset * 2, 1), math.max(absSize.Y - inset * 2, 1))

			local p1 = project(topLeft)
			local p2 = project(topRight)
			local p3 = project(bottomRight)

			local width = (p2 - p1).Magnitude
			local height = (p2 - p3).Magnitude

			part.CFrame = CFrame.fromMatrix((p1 + p3) / 2, cam.CFrame.XVector, cam.CFrame.YVector, cam.CFrame.ZVector)
			mesh.Scale = Vector3.new(width, height, 0)
		end)

		if not ok then
			part.Transparency = 1
		end
	end

	connections[#connections + 1] = RunService.RenderStepped:Connect(update)

	connections[#connections + 1] = screenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
		part.Transparency = screenGui.Enabled and 0.98 or 1
	end)

	local function cleanup()
		running = false
		for _, connection in ipairs(connections) do
			pcall(function()
				connection:Disconnect()
			end)
		end
		if part then
			part:Destroy()
		end
	end

	frame.Destroying:Connect(cleanup)
	update()

	return part, cleanup
end

local function ToColor3(value)
	if typeof(value) == "Color3" then
		return value
	end

	if typeof(value) == "string" then
		local hex = value:gsub("#", "")
		if #hex == 3 then
			local r = hex:sub(1, 1)
			local g = hex:sub(2, 2)
			local b = hex:sub(3, 3)
			hex = r .. r .. g .. g .. b .. b
		end
		local r = tonumber(hex:sub(1, 2), 16) or 255
		local g = tonumber(hex:sub(3, 4), 16) or 255
		local b = tonumber(hex:sub(5, 6), 16) or 255
		return Color3.fromRGB(r, g, b)
	end

	if typeof(value) == "table" then
		if value.R and value.G and value.B then
			return Color3.fromRGB(value.R, value.G, value.B)
		end
		if value[1] and value[2] and value[3] then
			return Color3.fromRGB(value[1], value[2], value[3])
		end
	end

	return Color3.fromRGB(255, 255, 255)
end

local function ResolveTheme(theme)
	local resolved = {}
	for key, value in pairs(theme) do
		if key == "Transparency" then
			resolved[key] = value
		else
			resolved[key] = ToColor3(value)
		end
	end
	return resolved
end

local function GenerateThemeFromAccent(accent)
	local h, s = accent:ToHSV()

	local background = Color3.fromHSV(h, math.clamp(s * 0.35, 0, 0.35), 0.085)
	local secondary = Color3.fromHSV(h, math.clamp(s * 0.35, 0, 0.35), 0.125)
	local descColor = Color3.fromHSV(h, math.clamp(s * 0.25, 0, 0.25), 0.68)

	return {
		Accent = accent,
		Background = background,
		Secondary = secondary,
		TitleColor = Color3.fromRGB(255, 255, 255),
		DescColor = descColor,
		SectionColor = accent,
		Transparency = 0.35,
	}
end

Library.Presets = {
	Dark = GenerateThemeFromAccent(Color3.fromRGB(130, 130, 140)),
	Purple = GenerateThemeFromAccent(Color3.fromRGB(150, 100, 255)),
	Rose = GenerateThemeFromAccent(Color3.fromRGB(255, 90, 130)),
	Blue = GenerateThemeFromAccent(Color3.fromRGB(80, 140, 255)),
	Green = GenerateThemeFromAccent(Color3.fromRGB(80, 220, 150)),
	Orange = GenerateThemeFromAccent(Color3.fromRGB(255, 150, 70)),
	Cyan = GenerateThemeFromAccent(Color3.fromRGB(70, 220, 220)),
	Gold = GenerateThemeFromAccent(Color3.fromRGB(230, 190, 90)),
}

Library.Presets.Dark.SectionColor = Color3.fromRGB(255, 255, 255)


local function GetRandomPresetName()
	local names = {}
	for name in pairs(Library.Presets) do
		table.insert(names, name)
	end
	return names[math.random(1, #names)]
end

local function CreateInstance(className, properties)
	local inst = Instance.new(className)
	for prop, value in pairs(properties) do
		inst[prop] = value
	end
	return inst
end

local function MakeDraggable(dragHandle, target)
	local dragging = false
	local dragStart
	local startPos

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragging then
				local delta = input.Position - dragStart
				target.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)
end

local function FadeTransparency(entries, duration, easingDirection)
	for _, entry in ipairs(entries) do
		local tween = TweenService:Create(
			entry.instance,
			TweenInfo.new(duration, Enum.EasingStyle.Quad, easingDirection),
			{ [entry.prop] = entry.target }
		)
		tween:Play()
	end
end

local function MakeResizable(handle, target, minSize, maxSize)
	local resizing = false
	local dragStart
	local startSize

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			dragStart = input.Position
			startSize = target.Size

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if resizing then
				local delta = input.Position - dragStart
				local newWidth = math.clamp(startSize.X.Offset + delta.X, minSize.X, maxSize.X)
				local newHeight = math.clamp(startSize.Y.Offset + delta.Y, minSize.Y, maxSize.Y)
				target.Size = UDim2.new(0, newWidth, 0, newHeight)
			end
		end
	end)
end

function Library:Window(config)
	config = config or {}

	local rawTheme = {}
	for key, value in pairs(Library.Presets.Dark) do
		rawTheme[key] = value
	end

	if type(config.Theme) == "string" then
		local themeName = config.Theme
		if themeName == "All" or themeName == "Random" then
			themeName = GetRandomPresetName()
		end

		local preset = Library.Presets[themeName]
		if preset then
			for key, value in pairs(preset) do
				rawTheme[key] = value
			end
		end
	elseif type(config.Theme) == "table" then
		if config.Theme.Accent and not config.Theme.Background and not config.Theme.Secondary then
			local generated = GenerateThemeFromAccent(ToColor3(config.Theme.Accent))
			for key, value in pairs(generated) do
				rawTheme[key] = value
			end
		end

		for key, value in pairs(config.Theme) do
			rawTheme[key] = value
		end
	end

	local theme = ResolveTheme(rawTheme)

	local self = setmetatable({}, Library)
	self.Theme = theme

	local tabWidth = config.TabWidth or 160
	local windowSize = config.Size or UDim2.fromOffset(830, 525)
	local minSize = Vector2.new(420, 300)
	local maxSize = Vector2.new(1200, 800)

	local screenGui = CreateInstance("ScreenGui", {
		Name = "VantaUI",
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})

	local mainFrame = CreateInstance("Frame", {
		Name = "MainFrame",
		Parent = screenGui,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = windowSize,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = theme.Transparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
	})

	CreateInstance("UICorner", {
		Parent = mainFrame,
		CornerRadius = UDim.new(0, 10),
	})

	local stroke = CreateInstance("UIStroke", {
		Parent = mainFrame,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.4,
	})

	local acrylicCleanup

	if config.Acrylic then
		EnableAcrylicLighting()
		local _, cleanup = AttachAcrylicGlass(mainFrame, screenGui)
		acrylicCleanup = cleanup

		local frostTint = CreateInstance("Frame", {
			Name = "AcrylicTint",
			Parent = mainFrame,
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.92,
			BorderSizePixel = 0,
			ZIndex = 0,
		})

		CreateInstance("UIGradient", {
			Parent = frostTint,
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0.85),
				NumberSequenceKeypoint.new(0.5, 0.95),
				NumberSequenceKeypoint.new(1, 0.85),
			}),
		})

		CreateInstance("ImageLabel", {
			Name = "AcrylicNoise",
			Parent = mainFrame,
			Image = "rbxassetid://9968344227",
			ImageTransparency = 0.94,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0, 128, 0, 128),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ZIndex = 0,
		})

		mainFrame.Destroying:Connect(function()
			DisableAcrylicLighting()
		end)
	end

	local topBar = CreateInstance("Frame", {
		Name = "TopBar",
		Parent = mainFrame,
		Size = UDim2.new(1, 0, 0, 50),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	local topBarDivider = CreateInstance("Frame", {
		Name = "Divider",
		Parent = topBar,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = 0.75,
		BorderSizePixel = 0,
	})

	local headerContainer = CreateInstance("Frame", {
		Name = "Header",
		Parent = topBar,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0, 0),
		Size = UDim2.new(1, -32, 1, 0),
	})

	CreateInstance("UIListLayout", {
		Parent = headerContainer,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = headerContainer,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Vanta",
		TextColor3 = theme.TitleColor,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})

	local descLabel = CreateInstance("TextLabel", {
		Name = "SubTitle",
		Parent = headerContainer,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.Gotham,
		Text = config.SubTitle or config.Description or "",
		TextColor3 = theme.DescColor,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
	})

	local verticalTabs = (windowSize.X.Offset / math.max(windowSize.Y.Offset, 1)) >= 1.3

	local tabsFrame = CreateInstance("Frame", {
		Name = "TabsFrame",
		Parent = mainFrame,
		Position = verticalTabs and UDim2.new(0, 0, 0, 50) or UDim2.new(0, 0, 0, 50),
		Size = verticalTabs and UDim2.new(0, tabWidth, 1, -50) or UDim2.new(1, 0, 0, 44),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	if verticalTabs then
		CreateInstance("Frame", {
			Name = "Divider",
			Parent = tabsFrame,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.new(0, 1, 1, 0),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.75,
			BorderSizePixel = 0,
		})
	else
		CreateInstance("Frame", {
			Name = "Divider",
			Parent = tabsFrame,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.75,
			BorderSizePixel = 0,
		})
	end

	CreateInstance("UIListLayout", {
		Parent = tabsFrame,
		FillDirection = verticalTabs and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 4),
		HorizontalAlignment = verticalTabs and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Left,
		VerticalAlignment = verticalTabs and Enum.VerticalAlignment.Top or Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	CreateInstance("UIPadding", {
		Parent = tabsFrame,
		PaddingTop = UDim.new(0, verticalTabs and 10 or 6),
		PaddingBottom = UDim.new(0, verticalTabs and 0 or 6),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	local contentFrame = CreateInstance("Frame", {
		Name = "ContentFrame",
		Parent = mainFrame,
		Position = verticalTabs and UDim2.new(0, tabWidth, 0, 50) or UDim2.new(0, 0, 0, 94),
		Size = verticalTabs and UDim2.new(1, -tabWidth, 1, -50) or UDim2.new(1, 0, 1, -94),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})

	CreateInstance("UIPadding", {
		Parent = contentFrame,
		PaddingTop = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
	})

	MakeDraggable(topBar, mainFrame)

	local resizeHandle
	if config.Resize then
		resizeHandle = CreateInstance("Frame", {
			Name = "ResizeHandle",
			Parent = mainFrame,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, 0, 1, 0),
			Size = UDim2.new(0, 26, 0, 26),
			BackgroundTransparency = 1,
			ZIndex = 10,
		})

		local grip = CreateInstance("Frame", {
			Name = "Grip",
			Parent = resizeHandle,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, -4, 1, -4),
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = theme.Accent,
			BackgroundTransparency = 0.3,
			ZIndex = 10,
		})

		CreateInstance("UICorner", {
			Parent = grip,
			CornerRadius = UDim.new(1, 0),
		})

		MakeResizable(resizeHandle, mainFrame, minSize, maxSize)
	end

	local iconButton
	local iconFrameStroke
	local iconCornerStroke
	if config.icno and config.icno.work then
		local hasImage = config.icno.IdIcon and config.icno.IdIcon ~= ""
		local iconSize = config.icno.Size or 44
		local innerImageSize = math.floor(iconSize * 0.9)
		local innerCornerSize = math.floor(iconSize * 0.45)

		local iconGui = CreateInstance("ScreenGui", {
			Name = "VantaIcon",
			Parent = PlayerGui,
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			DisplayOrder = 1000,
		})

		iconButton = CreateInstance("TextButton", {
			Name = "IconToggle",
			Parent = iconGui,
			Position = UDim2.new(0, 40, 0, 40),
			Size = UDim2.new(0, iconSize, 0, iconSize),
			BackgroundColor3 = theme.Background,
			BackgroundTransparency = hasImage and 1 or theme.Transparency,
			Text = "",
			AutoButtonColor = false,
		})

		local iconCorner = CreateInstance("UICorner", {
			Parent = iconButton,
			CornerRadius = UDim.new(0, 12),
		})

		iconFrameStroke = CreateInstance("UIStroke", {
			Parent = iconButton,
			Color = theme.Accent,
			Thickness = 1,
			Transparency = hasImage and 1 or 0.3,
		})

		if hasImage then
			CreateInstance("ImageLabel", {
				Parent = iconButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, innerImageSize, 0, innerImageSize),
				BackgroundTransparency = 1,
				Image = config.icno.IdIcon,
			})
		else
			local corner = CreateInstance("Frame", {
				Name = "Corner",
				Parent = iconButton,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(0, innerCornerSize, 0, innerCornerSize),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
			})

			CreateInstance("UICorner", {
				Parent = corner,
				CornerRadius = UDim.new(1, 0),
			})

			iconCornerStroke = CreateInstance("UIStroke", {
				Parent = corner,
				Color = theme.Accent,
				Thickness = 2,
				Transparency = 0,
			})
		end

		MakeDraggable(iconButton, iconButton)

		local iconDragged = false
		iconButton.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				iconDragged = false
			end
		end)

		iconButton.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				iconDragged = true
			end
		end)

		iconButton.MouseButton1Click:Connect(function()
			if not iconDragged then
				screenGui.Enabled = not screenGui.Enabled
			end
		end)
	end

	if config.MinimizeKey then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end
			if input.KeyCode == config.MinimizeKey then
				screenGui.Enabled = not screenGui.Enabled
			end
		end)
	end

	self.ScreenGui = screenGui
	self.MainFrame = mainFrame
	self.Stroke = stroke
	self.TopBar = topBar
	self.TitleLabel = titleLabel
	self.DescLabel = descLabel
	self.TabsFrame = tabsFrame
	self.ContentFrame = contentFrame
	self.TabsVertical = verticalTabs
	self.Tabs = {}
	self.SectionLabels = {}
	self.Controls = {}
	self.Pages = {}
	self.TabButtons = {}
	self.TabObjects = {}
	self.ActiveTabName = nil
	self.ResizeHandle = resizeHandle
	self.IconButton = iconButton
	self.IconFrameStroke = iconFrameStroke
	self.IconCornerStroke = iconCornerStroke
	self.AcrylicCleanup = acrylicCleanup

	if not Library._ErrorHookConnected then
		Library._ErrorHookConnected = true

		local ok, ScriptContext = pcall(function()
			return game:GetService("ScriptContext")
		end)

		if ok and ScriptContext then
			ScriptContext.Error:Connect(function(message, trace, errScript)
				local scriptName = errScript and errScript.Name or "Unknown"

				self:Notify({
					Title = "خطأ بالكود",
					Content = tostring(message),
					SubContent = "Script: " .. tostring(scriptName),
					Duration = 7,
					icone = {Work = true, IdIcon = "", Type = "up"},
				})
			end)
		end
	end

	return self
end

function Library:SetTheme(newTheme)
	local rawTheme = newTheme

	if type(newTheme) == "string" then
		local themeName = newTheme
		if themeName == "All" or themeName == "Random" then
			themeName = GetRandomPresetName()
		end
		rawTheme = Library.Presets[themeName] or {}
	elseif type(newTheme) == "table" and newTheme.Accent and not newTheme.Background and not newTheme.Secondary then
		local generated = GenerateThemeFromAccent(ToColor3(newTheme.Accent))
		for key, value in pairs(newTheme) do
			generated[key] = value
		end
		rawTheme = generated
	end

	local resolved = ResolveTheme(rawTheme)
	for key, value in pairs(resolved) do
		self.Theme[key] = value
	end

	self.Stroke.Color = self.Theme.Accent
	self.MainFrame.BackgroundColor3 = self.Theme.Background
	self.MainFrame.BackgroundTransparency = self.Theme.Transparency

	local topDivider = self.TopBar:FindFirstChild("Divider")
	if topDivider then
		topDivider.BackgroundColor3 = self.Theme.Accent
	end

	local tabsDivider = self.TabsFrame:FindFirstChild("Divider")
	if tabsDivider then
		tabsDivider.BackgroundColor3 = self.Theme.Accent
	end

	self.TitleLabel.TextColor3 = self.Theme.TitleColor
	self.DescLabel.TextColor3 = self.Theme.DescColor

	for _, section in ipairs(self.SectionLabels) do
		if section and section.Parent then
			if section:IsA("ImageLabel") then
				section.ImageColor3 = self.Theme.SectionColor
			else
				section.TextColor3 = self.Theme.SectionColor
			end
		end
	end

	if self.IconButton then
		if self.IconButton.BackgroundTransparency ~= 1 then
			self.IconButton.BackgroundColor3 = self.Theme.Background
		end
		if self.IconFrameStroke then
			self.IconFrameStroke.Color = self.Theme.Accent
		end
		if self.IconCornerStroke then
			self.IconCornerStroke.Color = self.Theme.Accent
		end
	end

	for _, refresh in ipairs(self.Controls) do
		pcall(refresh, self.Theme)
	end

	if self.ActiveTabName then
		self:SelectTab(self.ActiveTabName)
	end
end

function Library:SetTitle(text)
	self.TitleLabel.Text = text
end

function Library:SetSubTitle(text)
	self.DescLabel.Text = text
end

function Library:SelectTab(name)
	if not self.Pages[name] then
		return
	end

	for tabName, page in pairs(self.Pages) do
		page.Visible = (tabName == name)
	end

	for tabName, button in pairs(self.TabButtons) do
		local active = tabName == name
		local icon = button:FindFirstChildOfClass("ImageLabel")
		local label = button:FindFirstChildOfClass("TextLabel")

		button.BackgroundColor3 = self.Theme.Accent
		button.BackgroundTransparency = active and 0.85 or 1

		if icon then
			icon.ImageColor3 = active and self.Theme.Accent or self.Theme.DescColor
		end

		if label then
			label.TextColor3 = active and self.Theme.TitleColor or self.Theme.DescColor
		end
	end

	self.ActiveTabName = name
end

local Tab = {}
Tab.__index = Tab

function Library:AddTab(tabConfig)
	tabConfig = tabConfig or {}

	if tabConfig[1] ~= nil then
		local created = {}
		for _, entry in ipairs(tabConfig) do
			local single = entry

			if typeof(entry) == "table" and not entry.Name and not entry.Title and not entry.Icon then
				single = { Name = entry[1], Icon = entry[2] }
			end

			local tabObject = self:AddTab(single)
			table.insert(created, tabObject)
			created[tabObject.Name] = tabObject
		end

		return created
	end

	local name = tabConfig.Name or tabConfig.Title or ("Tab " .. tostring(#self.Tabs + 1))
	local iconId = ResolveIcon(tabConfig.Icon)

	local button = CreateInstance("TextButton", {
		Name = name,
		Parent = self.TabsFrame,
		BackgroundColor3 = self.Theme.Accent,
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Text = "",
		AutomaticSize = self.TabsVertical and Enum.AutomaticSize.None or Enum.AutomaticSize.X,
		Size = self.TabsVertical and UDim2.new(1, 0, 0, 34) or UDim2.new(0, 0, 1, 0),
		LayoutOrder = #self.Tabs + 1,
	})

	CreateInstance("UICorner", {
		Parent = button,
		CornerRadius = UDim.new(0, 8),
	})

	CreateInstance("UIPadding", {
		Parent = button,
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local innerLayout = CreateInstance("UIListLayout", {
		Parent = button,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	CreateInstance("ImageLabel", {
		Name = "Icon",
		Parent = button,
		BackgroundTransparency = 1,
		Image = iconId,
		ImageColor3 = self.Theme.DescColor,
		Size = UDim2.new(0, 18, 0, 18),
		LayoutOrder = 1,
	})

	CreateInstance("TextLabel", {
		Name = "Label",
		Parent = button,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.Gotham,
		Text = name,
		TextColor3 = self.Theme.DescColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})

	local page = CreateInstance("Frame", {
		Name = name .. "Page",
		Parent = self.ContentFrame,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = false,
	})

	CreateInstance("UIListLayout", {
		Parent = page,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	table.insert(self.Tabs, name)
	self.Pages[name] = page
	self.TabButtons[name] = button

	button.MouseButton1Click:Connect(function()
		self:SelectTab(name)
	end)

	if #self.Tabs == 1 then
		self:SelectTab(name)
	end

	local tabObject = setmetatable({
		Name = name,
		Page = page,
		Button = button,
		Window = self,
	}, Tab)

	self.TabObjects[name] = tabObject

	return tabObject
end

function Tab:Select()
	self.Window:SelectTab(self.Name)
end

local Section = {}
Section.__index = Section

function Tab:AddSection(config)
	local text = "Section"
	local iconName = nil

	if type(config) == "string" then
		text = config
	elseif type(config) == "table" then
		text = config.Name or config.Text or text
		iconName = config.Icon
	end

	local sectionFrame = CreateInstance("Frame", {
		Name = "Section",
		Parent = self.Page,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Page:GetChildren(),
	})

	CreateInstance("UIListLayout", {
		Parent = sectionFrame,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local headerFrame = CreateInstance("Frame", {
		Name = "Header",
		Parent = sectionFrame,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 24),
		LayoutOrder = 1,
	})

	CreateInstance("UIListLayout", {
		Parent = headerFrame,
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	if iconName and iconName ~= "" then
		CreateInstance("ImageLabel", {
			Name = "Icon",
			Parent = headerFrame,
			BackgroundTransparency = 1,
			Image = ResolveIcon(iconName),
			ImageColor3 = self.Window.Theme.SectionColor,
			Size = UDim2.new(0, 20, 0, 20),
			LayoutOrder = 1,
		})
	end

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = headerFrame,
		BackgroundTransparency = 1,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		Font = Enum.Font.GothamBold,
		Text = text,
		TextColor3 = self.Window.Theme.SectionColor,
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})

	local elementsFrame = CreateInstance("Frame", {
		Name = "Elements",
		Parent = sectionFrame,
		BackgroundColor3 = self.Window.Theme.Secondary,
		BackgroundTransparency = self.Window.Theme.Transparency,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = true,
		LayoutOrder = 2,
	})

	CreateInstance("UICorner", {
		Parent = elementsFrame,
		CornerRadius = UDim.new(0, 10),
	})

	local elementsStroke = CreateInstance("UIStroke", {
		Parent = elementsFrame,
		Color = self.Window.Theme.Accent,
		Thickness = 1,
		Transparency = 0.6,
	})

	CreateInstance("UIPadding", {
		Parent = elementsFrame,
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
	})

	CreateInstance("UIListLayout", {
		Parent = elementsFrame,
		Padding = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	table.insert(self.Window.Controls, function(theme2)
		elementsFrame.BackgroundColor3 = theme2.Secondary
		elementsFrame.BackgroundTransparency = theme2.Transparency
		elementsStroke.Color = theme2.Accent
	end)

	table.insert(self.Window.SectionLabels, titleLabel)

	local sectionIcon = headerFrame:FindFirstChild("Icon")
	if sectionIcon then
		table.insert(self.Window.SectionLabels, sectionIcon)
	end

	local sectionObject = setmetatable({
		Name = text,
		Frame = sectionFrame,
		TitleLabel = titleLabel,
		Container = elementsFrame,
		Tab = self,
		Window = self.Window,
	}, Section)

	return sectionObject
end

function Section:AddButton(config)
	config = config or {}
	local theme = self.Window.Theme

	local row = CreateInstance("TextButton", {
		Name = "Button",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local stroke = CreateInstance("UIStroke", {
		Parent = row,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.7,
	})

	CreateInstance("UIPadding", {
		Parent = row,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local hasDescription = config.Description and config.Description ~= ""

	local title = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Button",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		title.Size = UDim2.new(1, 0, 0, 16)
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = row,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, 0, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	row.MouseEnter:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseLeave:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Background
	end)

	row.MouseButton1Down:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Accent
	end)

	row.MouseButton1Up:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseButton1Click:Connect(function()
		local function runCallback()
			if config.Callback then
				local ok, err = pcall(config.Callback)
				if not ok then
					warn("Vanta Button Callback Error: " .. tostring(err))
				end
			end
		end

		if config.Confirm then
			self.Window:Dialog({
				Title = config.Confirm.Title or "تأكيد",
				Content = config.Confirm.Content or ('متأكد إنك تبي تنفذ "' .. (config.Name or "هذا الإجراء") .. '"؟'),
				Buttons = {
					{
						Title = config.Confirm.ConfirmText or "تأكيد",
						Callback = runCallback,
					},
					{
						Title = config.Confirm.CancelText or "إلغاء",
						Callback = config.Confirm.CancelCallback,
					},
				},
			})
		else
			runCallback()
		end
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		stroke.Color = theme2.Accent
		title.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
	end)

	return {
		Frame = row,
		Name = config.Name,
	}
end

function Section:AddToggle(config)
	config = config or {}
	local theme = self.Window.Theme
	local value = config.Default == true

	local row = CreateInstance("Frame", {
		Name = "Toggle",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local rowStroke = CreateInstance("UIStroke", {
		Parent = row,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.7,
	})

	CreateInstance("UIPadding", {
		Parent = row,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local hasDescription = config.Description and config.Description ~= ""

	local textContainer = CreateInstance("Frame", {
		Name = "TextContainer",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -56, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	local title = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = textContainer,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Toggle",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = textContainer,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, 0, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local switchBg = CreateInstance("Frame", {
		Name = "Switch",
		Parent = row,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 40, 0, 22),
		BackgroundColor3 = value and theme.Accent or theme.Background,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = switchBg,
		CornerRadius = UDim.new(1, 0),
	})

	local knob = CreateInstance("Frame", {
		Name = "Knob",
		Parent = switchBg,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
		Size = UDim2.new(0, 18, 0, 18),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = knob,
		CornerRadius = UDim.new(1, 0),
	})

	local clickArea = CreateInstance("TextButton", {
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Text = "",
		AutoButtonColor = false,
	})

	local function setValue(newValue, fireCallback)
		value = newValue
		local currentTheme = self.Window.Theme

		local targetPos = value and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
		local targetColor = value and currentTheme.Accent or currentTheme.Background

		TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = targetPos,
		}):Play()

		TweenService:Create(switchBg, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = targetColor,
		}):Play()

		if fireCallback and config.Callback then
			local ok, err = pcall(config.Callback, value)
			if not ok then
				warn("Vanta Toggle Callback Error: " .. tostring(err))
			end
		end
	end

	clickArea.MouseButton1Click:Connect(function()
		setValue(not value, true)
	end)

	row.MouseEnter:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Secondary
	end)

	row.MouseLeave:Connect(function()
		row.BackgroundColor3 = self.Window.Theme.Background
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		title.TextColor3 = theme2.TitleColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		switchBg.BackgroundColor3 = value and theme2.Accent or theme2.Background
	end)

	return {
		Frame = row,
		Name = config.Name,
		Set = function(_, newValue)
			setValue(newValue, false)
		end,
		Get = function()
			return value
		end,
	}
end

function Section:AddSlider(name, config)
	config = config or {}
	local theme = self.Window.Theme

	local title = config.Title or name or "Slider"
	local min = config.Min or 0
	local max = config.Max or 100
	local rounding = config.Rounding or 0

	local function roundValue(v)
		local mult = 10 ^ rounding
		return math.floor(v * mult + 0.5) / mult
	end

	local value = roundValue(math.clamp(config.Default or min, min, max))

	local row = CreateInstance("Frame", {
		Name = "Slider",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local rowStroke = CreateInstance("UIStroke", {
		Parent = row,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.7,
	})

	CreateInstance("UIPadding", {
		Parent = row,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 14),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, -50, 0, 16),
		Font = Enum.Font.Gotham,
		Text = title,
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local valueLabel = CreateInstance("TextLabel", {
		Name = "Value",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 50, 0, 16),
		Font = Enum.Font.GothamBold,
		Text = tostring(value),
		TextColor3 = theme.Accent,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Right,
	})

	local hasDescription = config.Description and config.Description ~= ""
	local trackYOffset = 24

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = row,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, 0, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		trackYOffset = 40
	end

	local track = CreateInstance("Frame", {
		Name = "Track",
		Parent = row,
		Position = UDim2.new(0, 0, 0, trackYOffset),
		Size = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = theme.Secondary,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = track,
		CornerRadius = UDim.new(1, 0),
	})

	local fill = CreateInstance("Frame", {
		Name = "Fill",
		Parent = track,
		Size = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = theme.Accent,
		BorderSizePixel = 0,
	})

	CreateInstance("UICorner", {
		Parent = fill,
		CornerRadius = UDim.new(1, 0),
	})

	local knob = CreateInstance("Frame", {
		Name = "Knob",
		Parent = track,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 14, 0, 14),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 2,
	})

	CreateInstance("UICorner", {
		Parent = knob,
		CornerRadius = UDim.new(1, 0),
	})

	local function updateVisual()
		local ratio = (value - min) / math.max(max - min, 0.0001)
		fill.Size = UDim2.new(ratio, 0, 1, 0)
		knob.Position = UDim2.new(ratio, 0, 0.5, 0)
		valueLabel.Text = tostring(value)
	end
	updateVisual()

	local dragging = false

	local function setFromInputX(inputX, fireCallback)
		local absPos = track.AbsolutePosition.X
		local absSize = math.max(track.AbsoluteSize.X, 1)
		local ratio = math.clamp((inputX - absPos) / absSize, 0, 1)
		local raw = min + (max - min) * ratio
		local newValue = math.clamp(roundValue(raw), min, max)

		if newValue ~= value then
			value = newValue
			updateVisual()
			if fireCallback and config.Callback then
				local ok, err = pcall(config.Callback, value)
				if not ok then
					warn("Vanta Slider Callback Error: " .. tostring(err))
				end
			end
		end
	end

	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			setFromInputX(input.Position.X, true)

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			setFromInputX(input.Position.X, true)
		end
	end)

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		valueLabel.TextColor3 = theme2.Accent
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		track.BackgroundColor3 = theme2.Secondary
		fill.BackgroundColor3 = theme2.Accent
	end)

	return {
		Frame = row,
		Name = title,
		Set = function(_, newValue)
			value = math.clamp(roundValue(newValue), min, max)
			updateVisual()
		end,
		Get = function()
			return value
		end,
	}
end

function Section:_BuildDropdown(config, isMulti)
	config = config or {}
	local theme = self.Window.Theme
	local options = config.Options or {}
	local placeholder = config.Placeholder or "Select..."

	local selectedSet = {}
	local selectedSingle = nil

	if isMulti then
		if typeof(config.Default) == "table" then
			for _, v in ipairs(config.Default) do
				selectedSet[v] = true
			end
		end
	else
		selectedSingle = config.Default
	end

	local row = CreateInstance("Frame", {
		Name = isMulti and "MultiDropdown" or "Dropdown",
		Parent = self.Container,
		BackgroundColor3 = theme.Background,
		BackgroundTransparency = 0,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ClipsDescendants = true,
		LayoutOrder = #self.Container:GetChildren(),
	})

	CreateInstance("UICorner", {
		Parent = row,
		CornerRadius = UDim.new(0, 6),
	})

	local rowStroke = CreateInstance("UIStroke", {
		Parent = row,
		Color = theme.Accent,
		Thickness = 1,
		Transparency = 0.7,
	})

	CreateInstance("UIPadding", {
		Parent = row,
		PaddingTop = UDim.new(0, 10),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
	})

	local hasDescription = config.Description and config.Description ~= ""
	local headerHeight = hasDescription and 34 or 16

	local header = CreateInstance("TextButton", {
		Name = "Header",
		Parent = row,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, headerHeight),
		Text = "",
		AutoButtonColor = false,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0),
		Size = UDim2.new(1, -100, 0, 16),
		Font = Enum.Font.Gotham,
		Text = config.Name or "Dropdown",
		TextColor3 = theme.TitleColor,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	local descLabel
	if hasDescription then
		descLabel = CreateInstance("TextLabel", {
			Name = "Description",
			Parent = row,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 0, 0, 18),
			Size = UDim2.new(1, -100, 0, 14),
			Font = Enum.Font.Gotham,
			Text = config.Description,
			TextColor3 = theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
	end

	local chevron = CreateInstance("ImageLabel", {
		Name = "Chevron",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 1),
		Size = UDim2.new(0, 14, 0, 14),
		Image = ResolveIcon("chevron-down"),
		ImageColor3 = theme.DescColor,
	})

	local valueLabel = CreateInstance("TextLabel", {
		Name = "Value",
		Parent = row,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -20, 0, 0),
		Size = UDim2.new(0, 80, 0, 16),
		Font = Enum.Font.Gotham,
		Text = placeholder,
		TextColor3 = theme.Accent,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	local optionsContainer = CreateInstance("Frame", {
		Name = "Options",
		Parent = row,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, headerHeight + 8),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Visible = false,
	})

	CreateInstance("UIListLayout", {
		Parent = optionsContainer,
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local optionRows = {}

	local function updateDisplay()
		if isMulti then
			local list = {}
			for _, optionName in ipairs(options) do
				if selectedSet[optionName] then
					table.insert(list, optionName)
				end
			end
			valueLabel.Text = (#list == 0) and placeholder or table.concat(list, ", ")
		else
			valueLabel.Text = (selectedSingle == nil or selectedSingle == "") and placeholder or tostring(selectedSingle)
		end
	end

	local isOpen = false
	local function setOpen(open)
		isOpen = open
		optionsContainer.Visible = open

		local currentTheme = self.Window.Theme
		TweenService:Create(chevron, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Rotation = open and 180 or 0,
		}):Play()
	end

	header.MouseButton1Click:Connect(function()
		setOpen(not isOpen)
	end)

	for _, optionName in ipairs(options) do
		local optionRow = CreateInstance("TextButton", {
			Name = "Option",
			Parent = optionsContainer,
			BackgroundColor3 = theme.Secondary,
			BackgroundTransparency = 0,
			Size = UDim2.new(1, 0, 0, 28),
			Text = "",
			AutoButtonColor = false,
			LayoutOrder = #optionsContainer:GetChildren(),
		})

		CreateInstance("UICorner", {
			Parent = optionRow,
			CornerRadius = UDim.new(0, 5),
		})

		local optionLabel = CreateInstance("TextLabel", {
			Parent = optionRow,
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 10, 0, 0),
			Size = UDim2.new(1, -34, 1, 0),
			Font = Enum.Font.Gotham,
			Text = optionName,
			TextColor3 = theme.TitleColor,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
		})

		local checkIcon
		if isMulti then
			checkIcon = CreateInstance("ImageLabel", {
				Parent = optionRow,
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -8, 0.5, 0),
				Size = UDim2.new(0, 16, 0, 16),
				Image = ResolveIcon("check"),
				ImageColor3 = theme.Accent,
				ImageTransparency = selectedSet[optionName] and 0 or 1,
			})
		end

		optionRow.MouseEnter:Connect(function()
			optionRow.BackgroundColor3 = self.Window.Theme.Background
		end)

		optionRow.MouseLeave:Connect(function()
			optionRow.BackgroundColor3 = self.Window.Theme.Secondary
		end)

		optionRow.MouseButton1Click:Connect(function()
			if isMulti then
				selectedSet[optionName] = not selectedSet[optionName]
				checkIcon.ImageTransparency = selectedSet[optionName] and 0 or 1
				updateDisplay()

				if config.Callback then
					local list = {}
					for _, name in ipairs(options) do
						if selectedSet[name] then
							table.insert(list, name)
						end
					end
					local ok, err = pcall(config.Callback, list)
					if not ok then
						warn("Vanta Dropdown Callback Error: " .. tostring(err))
					end
				end
			else
				selectedSingle = optionName
				updateDisplay()
				setOpen(false)

				if config.Callback then
					local ok, err = pcall(config.Callback, selectedSingle)
					if not ok then
						warn("Vanta Dropdown Callback Error: " .. tostring(err))
					end
				end
			end
		end)

		table.insert(optionRows, { Frame = optionRow, Label = optionLabel, Check = checkIcon, Name = optionName })
	end

	updateDisplay()

	table.insert(self.Window.Controls, function(theme2)
		row.BackgroundColor3 = theme2.Background
		rowStroke.Color = theme2.Accent
		titleLabel.TextColor3 = theme2.TitleColor
		valueLabel.TextColor3 = theme2.Accent
		chevron.ImageColor3 = theme2.DescColor
		if descLabel then
			descLabel.TextColor3 = theme2.DescColor
		end
		for _, opt in ipairs(optionRows) do
			opt.Frame.BackgroundColor3 = theme2.Secondary
			opt.Label.TextColor3 = theme2.TitleColor
			if opt.Check then
				opt.Check.ImageColor3 = theme2.Accent
			end
		end
	end)

	return {
		Frame = row,
		Set = function(_, newValue)
			if isMulti then
				selectedSet = {}
				if typeof(newValue) == "table" then
					for _, v in ipairs(newValue) do
						selectedSet[v] = true
					end
				end
				for _, opt in ipairs(optionRows) do
					if opt.Check then
						opt.Check.ImageTransparency = selectedSet[opt.Name] and 0 or 1
					end
				end
			else
				selectedSingle = newValue
			end
			updateDisplay()
		end,
		Get = function()
			if isMulti then
				local list = {}
				for _, optionName in ipairs(options) do
					if selectedSet[optionName] then
						table.insert(list, optionName)
					end
				end
				return list
			end
			return selectedSingle
		end,
	}
end

function Section:AddDropdown(config)
	return self:_BuildDropdown(config, false)
end

function Section:AddMultiDropdown(config)
	return self:_BuildDropdown(config, true)
end

function Library:SafeFind(root, ...)
	local current = root
	local pathParts = {...}

	if not current then
		self:Notify({
			Title = "خطأ بالمسار",
			Content = "الجذر (root) اللي أعطيته فارغ (nil)",
			Duration = 6,
			icone = {Work = true, IdIcon = "", Type = "up"},
		})
		return nil
	end

	for _, part in ipairs(pathParts) do
		local ok, child = pcall(function()
			return current:WaitForChild(part, 3)
		end)

		if not ok or not child then
			self:Notify({
				Title = "خطأ بالمسار",
				Content = 'تعذر إيجاد "' .. tostring(part) .. '" داخل ' .. tostring(current.Name),
				Duration = 6,
				icone = {Work = true, IdIcon = "", Type = "up"},
			})
			return nil
		end

		current = child
	end

	return current
end

function Library:SafePlayer(nameOrUserId)
	local Players = game:GetService("Players")
	local player = nil

	if type(nameOrUserId) == "number" then
		local ok, result = pcall(function()
			return Players:GetPlayerByUserId(nameOrUserId)
		end)
		player = ok and result or nil
	else
		local ok, result = pcall(function()
			return Players:FindFirstChild(tostring(nameOrUserId))
		end)
		player = ok and result or nil
	end

	if not player then
		self:Notify({
			Title = "خطأ باللاعب",
			Content = "ما لكيت لاعب بالاسم/الآيدي: " .. tostring(nameOrUserId),
			Duration = 6,
			icone = {Work = true, IdIcon = "", Type = "up"},
		})
		return nil
	end

	return player
end

function Library:GetNotifyContainer(position)
	self.NotifyGui = self.NotifyGui or CreateInstance("ScreenGui", {
		Name = "VantaNotifications",
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 1500,
	})

	self.NotifyContainers = self.NotifyContainers or {}

	if self.NotifyContainers[position] then
		return self.NotifyContainers[position]
	end

	local container = CreateInstance("Frame", {
		Name = "NotifyContainer_" .. position,
		Parent = self.NotifyGui,
		BackgroundTransparency = 1,
		AnchorPoint = position == "down" and Vector2.new(1, 1) or Vector2.new(1, 0),
		Position = position == "down" and UDim2.new(1, -20, 1, -20) or UDim2.new(1, -20, 0, 20),
		Size = UDim2.new(0, 300, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	CreateInstance("UIListLayout", {
		Parent = container,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = position == "down" and Enum.VerticalAlignment.Bottom or Enum.VerticalAlignment.Top,
	})

	self.NotifyContainers[position] = container
	return container
end

function Library:Notify(config)
	config = config or {}

	local iconCfg = config.icone

	if iconCfg == true then
		iconCfg = { Work = true, IdIcon = "", Type = "up" }
	elseif iconCfg == false or iconCfg == nil then
		iconCfg = { Work = false }
	end
	local position = iconCfg.Type == "down" and "down" or "up"
	local container = self:GetNotifyContainer(position)

	self.NotifyOrder = (self.NotifyOrder or 0) + 1

	local fadeEntries = {}

	local card = CreateInstance("Frame", {
		Name = "Notification",
		Parent = container,
		BackgroundColor3 = self.Theme.Background,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = self.NotifyOrder,
		BorderSizePixel = 0,
	})
	table.insert(fadeEntries, { instance = card, prop = "BackgroundTransparency", target = self.Theme.Transparency })

	CreateInstance("UICorner", {
		Parent = card,
		CornerRadius = UDim.new(0, 10),
	})

	local cardStroke = CreateInstance("UIStroke", {
		Parent = card,
		Color = self.Theme.Accent,
		Thickness = 1,
		Transparency = 1,
	})
	table.insert(fadeEntries, { instance = cardStroke, prop = "Transparency", target = 0.3 })

	CreateInstance("UIPadding", {
		Parent = card,
		PaddingTop = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
	})

	local hasIcon = iconCfg.Work == true

	local textOffset = 0
	if hasIcon then
		textOffset = 32

		local iconId = (iconCfg.IdIcon and iconCfg.IdIcon ~= "") and ResolveIcon(iconCfg.IdIcon) or ResolveIcon("alert-triangle")

		local iconLabel = CreateInstance("ImageLabel", {
			Name = "Icon",
			Parent = card,
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			Image = iconId,
			ImageColor3 = self.Theme.Accent,
			Position = UDim2.new(0, 0, 0, 2),
			Size = UDim2.new(0, 22, 0, 22),
		})
		table.insert(fadeEntries, { instance = iconLabel, prop = "ImageTransparency", target = 0 })
	end

	local textContainer = CreateInstance("Frame", {
		Name = "TextContainer",
		Parent = card,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, textOffset, 0, 0),
		Size = UDim2.new(1, -textOffset, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})

	CreateInstance("UIListLayout", {
		Parent = textContainer,
		Padding = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = textContainer,
		BackgroundTransparency = 1,
		TextTransparency = 1,
		Size = UDim2.new(1, 0, 0, 18),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Notification",
		TextColor3 = self.Theme.TitleColor,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		LayoutOrder = 1,
	})
	table.insert(fadeEntries, { instance = titleLabel, prop = "TextTransparency", target = 0 })

	if config.Content and config.Content ~= "" then
		local contentLabel = CreateInstance("TextLabel", {
			Name = "Content",
			Parent = textContainer,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = Enum.Font.Gotham,
			Text = config.Content,
			TextColor3 = self.Theme.DescColor,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 2,
		})
		table.insert(fadeEntries, { instance = contentLabel, prop = "TextTransparency", target = 0 })
	end

	if config.SubContent and config.SubContent ~= "" then
		local subContentLabel = CreateInstance("TextLabel", {
			Name = "SubContent",
			Parent = textContainer,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = Enum.Font.Gotham,
			Text = config.SubContent,
			TextColor3 = self.Theme.DescColor,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 3,
		})
		table.insert(fadeEntries, { instance = subContentLabel, prop = "TextTransparency", target = 0 })
	end

	local closeButton = CreateInstance("TextButton", {
		Name = "Close",
		Parent = card,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Text = "",
		AutoButtonColor = false,
	})

	local closeIcon = CreateInstance("ImageLabel", {
		Parent = closeButton,
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Image = ResolveIcon("x"),
		ImageColor3 = self.Theme.DescColor,
	})
	table.insert(fadeEntries, { instance = closeIcon, prop = "ImageTransparency", target = 0 })

	local dismissed = false
	local function dismiss()
		if dismissed then
			return
		end
		dismissed = true

		local exitEntries = {}
		for _, entry in ipairs(fadeEntries) do
			table.insert(exitEntries, { instance = entry.instance, prop = entry.prop, target = 1 })
		end

		FadeTransparency(exitEntries, 0.2, Enum.EasingDirection.In)

		task.delay(0.2, function()
			card:Destroy()
		end)
	end

	closeButton.MouseButton1Click:Connect(dismiss)

	FadeTransparency(fadeEntries, 0.25, Enum.EasingDirection.Out)

	if config.SoundID and config.SoundID ~= "" then
		local soundId = tostring(config.SoundID)
		if not soundId:match("^rbxassetid://") then
			soundId = "rbxassetid://" .. soundId
		end

		local sound = CreateInstance("Sound", {
			Name = "NotifySound",
			Parent = card,
			SoundId = soundId,
			Volume = config.SoundVolume or 1,
			PlaybackSpeed = config.SoundSpeed or 1,
			Looped = config.SoundLooped or false,
		})

		sound.Ended:Connect(function()
			if not config.SoundLooped then
				sound:Destroy()
			end
		end)

		pcall(function()
			sound:Play()
		end)
	end

	if config.Duration then
		task.delay(config.Duration, dismiss)
	end

	return {
		Frame = card,
		Dismiss = dismiss,
	}
end

function Library:Dialog(config)
	config = config or {}

	self.DialogGui = self.DialogGui or CreateInstance("ScreenGui", {
		Name = "VantaDialog",
		Parent = PlayerGui,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 2000,
	})

	local fadeEntries = {}

	local backdrop = CreateInstance("Frame", {
		Name = "Backdrop",
		Parent = self.DialogGui,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Active = true,
	})
	table.insert(fadeEntries, { instance = backdrop, prop = "BackgroundTransparency", target = 0.5 })

	local card = CreateInstance("Frame", {
		Name = "DialogCard",
		Parent = backdrop,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 380, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = self.Theme.Background,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	table.insert(fadeEntries, { instance = card, prop = "BackgroundTransparency", target = self.Theme.Transparency })

	CreateInstance("UICorner", {
		Parent = card,
		CornerRadius = UDim.new(0, 12),
	})

	local cardStroke = CreateInstance("UIStroke", {
		Parent = card,
		Color = self.Theme.Accent,
		Thickness = 1,
		Transparency = 1,
	})
	table.insert(fadeEntries, { instance = cardStroke, prop = "Transparency", target = 0.3 })

	CreateInstance("UIPadding", {
		Parent = card,
		PaddingTop = UDim.new(0, 20),
		PaddingBottom = UDim.new(0, 20),
		PaddingLeft = UDim.new(0, 20),
		PaddingRight = UDim.new(0, 20),
	})

	local layout = CreateInstance("UIListLayout", {
		Parent = card,
		Padding = UDim.new(0, 14),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local titleLabel = CreateInstance("TextLabel", {
		Name = "Title",
		Parent = card,
		BackgroundTransparency = 1,
		TextTransparency = 1,
		Size = UDim2.new(1, 0, 0, 20),
		Font = Enum.Font.GothamBold,
		Text = config.Title or "Dialog",
		TextColor3 = self.Theme.TitleColor,
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		LayoutOrder = 1,
	})
	table.insert(fadeEntries, { instance = titleLabel, prop = "TextTransparency", target = 0 })

	if config.Content and config.Content ~= "" then
		local contentLabel = CreateInstance("TextLabel", {
			Name = "Content",
			Parent = card,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = Enum.Font.Gotham,
			Text = config.Content,
			TextColor3 = self.Theme.DescColor,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			LayoutOrder = 2,
		})
		table.insert(fadeEntries, { instance = contentLabel, prop = "TextTransparency", target = 0 })
	end

	local buttons = config.Buttons or {}
	local buttonCount = math.max(#buttons, 1)

	local buttonsRow = CreateInstance("Frame", {
		Name = "Buttons",
		Parent = card,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 36),
		LayoutOrder = 3,
	})

	CreateInstance("UIListLayout", {
		Parent = buttonsRow,
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	local dismissed = false
	local function close()
		if dismissed then
			return
		end
		dismissed = true

		local exitEntries = {}
		for _, entry in ipairs(fadeEntries) do
			table.insert(exitEntries, { instance = entry.instance, prop = entry.prop, target = 1 })
		end

		FadeTransparency(exitEntries, 0.18, Enum.EasingDirection.In)

		task.delay(0.18, function()
			backdrop:Destroy()
		end)
	end

	for index, buttonConfig in ipairs(buttons) do
		local buttonFrame = CreateInstance("TextButton", {
			Name = "Button" .. index,
			Parent = buttonsRow,
			Size = UDim2.new(1 / buttonCount, -8, 1, 0),
			BackgroundColor3 = self.Theme.Background,
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,
			LayoutOrder = index,
		})
		table.insert(fadeEntries, {
			instance = buttonFrame,
			prop = "BackgroundTransparency",
			target = 0,
		})

		CreateInstance("UICorner", {
			Parent = buttonFrame,
			CornerRadius = UDim.new(0, 6),
		})

		local btnStroke = CreateInstance("UIStroke", {
			Parent = buttonFrame,
			Color = self.Theme.Accent,
			Thickness = 1,
			Transparency = 1,
		})
		table.insert(fadeEntries, { instance = btnStroke, prop = "Transparency", target = 0.7 })

		local btnLabel = CreateInstance("TextLabel", {
			Parent = buttonFrame,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Font = Enum.Font.Gotham,
			Text = buttonConfig.Title or ("Button " .. index),
			TextColor3 = self.Theme.TitleColor,
			TextSize = 13,
		})
		table.insert(fadeEntries, { instance = btnLabel, prop = "TextTransparency", target = 0 })

		buttonFrame.MouseEnter:Connect(function()
			buttonFrame.BackgroundColor3 = self.Theme.Secondary
		end)

		buttonFrame.MouseLeave:Connect(function()
			buttonFrame.BackgroundColor3 = self.Theme.Background
		end)

		buttonFrame.MouseButton1Down:Connect(function()
			buttonFrame.BackgroundColor3 = self.Theme.Accent
		end)

		buttonFrame.MouseButton1Up:Connect(function()
			buttonFrame.BackgroundColor3 = self.Theme.Secondary
		end)

		buttonFrame.MouseButton1Click:Connect(function()
			if buttonConfig.Callback then
				local ok, err = pcall(buttonConfig.Callback)
				if not ok then
					warn("Vanta Dialog Callback Error: " .. tostring(err))
				end
			end
			close()
		end)
	end

	FadeTransparency(fadeEntries, 0.2, Enum.EasingDirection.Out)

	return {
		Frame = card,
		Close = close,
	}
end

function Library:Destroy()
	if self.IconButton and self.IconButton.Parent then
		self.IconButton.Parent:Destroy()
	end
	if self.NotifyGui then
		self.NotifyGui:Destroy()
		self.NotifyGui = nil
		self.NotifyContainers = nil
	end
	if self.DialogGui then
		self.DialogGui:Destroy()
		self.DialogGui = nil
	end
	if self.ScreenGui then
		self.ScreenGui:Destroy()
	end
end

return Library
