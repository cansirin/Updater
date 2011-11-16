request = require 'request'
log4js  = require 'log4js'
log     = log4js.getLogger('[Updater]')
cs = require "coffee-script"
os = require "os"
fs = require "fs"

masterUpdateConfigUrl = "http://devrim.kodingen.com/_/updater.txt"

class Updater
  @getConfig = (callback)->
    request masterUpdateConfigUrl,(err,res,body)->
      config = cs.eval body
      if config?[os.hostname()]?
        callback null,config[os.hostname()]
      else
        callback yes
  @notify = ()->
    log.info "sysadmins are being notified."

Updater.getConfig (err,config)->
  unless err
    console.log config
  else
    log.error "no config found for hostname:[#{os.hostname()}] at [#{masterUpdateConfigUrl}]"
    Updater.notify()

