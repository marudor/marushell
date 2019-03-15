// @flow
const fs = require('fs');

const argv = process.argv;
const commitFilePath = argv[2];
const branch = argv[3];
const branchRegex = /(story|task|feature|bug)\/(EV-)?(\d+)\w*$/;
const r = branchRegex.exec(branch);
if (!r || !r[3]) {
  process.exit(0);
}

const ticketNumber = r[3];

const msg = fs.readFileSync(argv[2], 'utf8');

const variations = [`EV-${ticketNumber}`, 'No-Ticket'];
if (variations.some(v => msg.startsWith(v))) {
  process.exit(0);
}

fs.writeFileSync(argv[2], `EV-${ticketNumber} ${msg}`);
