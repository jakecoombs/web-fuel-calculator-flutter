Map<String, List<String>> cars;
List<String> tracks;
List<String> trackConditions = ['Dry', 'Wet'];

Future initData() async {
  cars = {
    'GT3': [
      'Aston Martin Racing V12 Vantage',
      'Aston Martin Racing V8 Vantage',
      'Audi R8 LMS',
      'Audi R8 LMS Evo',
      'BMW M6 GT3',
      'Bentley Continental GT3 2015',
      'Bentley Continental GT3 2018',
      'Emil Frey Jaguar GT3',
      'Ferrari 488 GT3',
      'Ferrari 488 GT3 Evo',
      'Honda NSX GT3',
      'Honda NSX GT3 Evo',
      'Lamborghini Huracan GT3',
      'Lamborghini Huracan GT3 Evo',
      'Lexus RC F GT3',
      'McLaren 650S GT3',
      'McLaren 720S GT3',
      'Mercedes-AMG GT3',
      'Mercedes-AMG GT3 Evo',
      'Nissan GT-R Nismo GT3 2015',
      'Nissan GT-R Nismo GT3 2018',
      'Porsche 991 GT3 R',
      'Porsche 991 II GT3 R',
      'Reiter Engineering R-EX GT3'
    ],
    'GT4': [
      'Alpine A110 GT4',
      'Aston Martin V8 Vantage GT4',
      'Audi R8 LMS GT4',
      'BMW M4 GT4',
      'Chevrolet Camaro GT4.R',
      'Ginetta G55 GT4',
      'KTM X-Bow GT4',
      'Maserati Granturismo MC GT4',
      'McLaren 570S GT4',
      'Mercedes-AMG GT4',
      'Porsche 718 Cayman GT4 Clubsport'
    ],
    'Cup': [
      'Porsche 991 II GT3 Cup',
    ],
    'ST': [
      'Lamborghini Huracan ST',
    ]
  };
  cars['GT3'].sort();
  cars['GT4'].sort();

  tracks = [
    'Barcelona',
    'Brands Hatch',
    'Donington',
    'Hungaroring',
    'Imola',
    'Kyalami',
    'Laguna Seca',
    'Misano',
    'Monza',
    'Mount Panorama',
    'Nurburgring',
    'Oulton Park',
    'Paul Ricard',
    'Silverstone',
    'Snetterton',
    'Spa-Francorchamps',
    'Suzuka',
    'Zandvoort',
    'Zolder'
  ];
  tracks.sort();
}

String findCarClass(String carName) {
  var found = false;
  var carClass = '';
  cars.keys.forEach((key) {
    if (cars[key].contains(carName)) {
      found = true;
      carClass = key;
    }
  });
  return found ? carClass : null;
}
