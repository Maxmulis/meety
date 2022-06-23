// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"
import Reveal from 'stimulus-reveal-controller'

import controllers from "./**/*_controller.js"
controllers.forEach((controller) => {
  application.register(controller.name, controller.module.default)
})
application.register('reveal', Reveal)
