local fennel = require('fennel')
table.insert(package.loaders or package.searchers, fennel.searcher)
fennel.path = './?.fnl;./?/init.fnl;' .. vim.fn.stdpath('config') .. '/fnl/?.fnl'
require('config')
