foo = { '2': { '1': { row: '2', col: '1', value: 'Client' },  '2': { row: '2', col: '2', value: 'Environnement' },  '3': { row: '2', col: '3', value: 'Url' },  '4': { row: '2', col: '4', value: 'Identifiant' },  '5': { row: '2', col: '5', value: 'Mot de passe' } },'3': { '1': { row: '3', col: '1', value: 'fake site' },  '2': { row: '3', col: '2', value: 'production' },  '3': { row: '3', col: '3', value: 'fake.com' },  '4': { row: '3', col: '4', value: 'foo' },  '5': { row: '3', col: '5', value: 'bar' } },'4': { '2': { row: '4', col: '2', value: 'staging' },  '3': { row: '4', col: '3', value: 'staging.fake.com' },  '4': { row: '4', col: '4', value: 'foo' },  '5': { row: '4', col: '5', value: 'bar' } },'5': { '1': { row: '5', col: '1', value: 'dummy site' },  '2': { row: '5', col: '2', value: 'production' },  '3': { row: '5', col: '3', value: 'dummy.io' },  '4': { row: '5', col: '4', value: 'bip' },  '5': { row: '5', col: '5', value: 'bop' } } }

for row_number, row of foo
  console.log(row['1'])
  # console.log(row_number) if new RegExp('fake').test row['1'].value