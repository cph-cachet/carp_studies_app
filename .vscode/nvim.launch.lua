require('flutter-tools').setup_project({
  {
    name = '[DEBUG] Local',
    target = 'lib/main.dart',
    dart_define = {
      ['deployment-mode'] = 'local',
      ['debug-level'] = 'debug',
    },
  },
  {
    name = 'Local',
    target = 'lib/main.dart',
    dart_define = {
      ['deployment-mode'] = 'local',
    },
  },
  {
    name = 'Development',
    target = 'lib/main.dart',
    dart_define = {
      ['deployment-mode'] = 'dev',
    },
  },
  {
    name = 'Test',
    target = 'lib/main.dart',
    dart_define = {
      ['deployment-mode'] = 'test',
    },
  },
  {
    name = 'Production',
    target = 'lib/main.dart',
    dart_define = {
      ['deployment-mode'] = 'production',
    },
  },
})
