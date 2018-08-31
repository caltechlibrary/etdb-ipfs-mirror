// 2018-08-30 <mhucka@caltech.edu>
// Based on code sent by Davi Ortega.
// This uses OIP to list the objects registered by the Jensen lab.
// It prints the results to standard output.
// Run it using node v8 or later, like this:
//
//    npm install oip-js opi-index
//    node get-etdb-hashes.js

const OIPJS = require('oip-js').OIPJS
const Core = OIPJS({
   indexFilters: {
       publisher: 'FTSTq8xx8yWUKJA5E3bgXLzZqqG9V6dvnr' // Jensen Lab address
   }
})
Core.Index.getArtifacts('*', (artifacts) => {
    var len = artifacts.length;
    for (i = 0; i < len; i++) {
        console.log(artifacts[i].artifact.storage.location);
    }
})
