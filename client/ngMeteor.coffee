define("ngMeteor", [], ->
  angular.module('ngMeteor.directives', [])

  angular.module('ngMeteor.services', [])

  angular.module('ngMeteor.blade', []).run(['$templateCache', '$rootScope', '$compile',
    ($templateCache, $rootScope, $compile) ->
      bodyTemplate = Template.body
      if !bodyTemplate
        throw new Error("A body template must be defined ('body.blade')")

      # Render each template and place in Angular's template cache
      $templateCache.put "#{key}.blade", render() for own key, render of Template

      # Render the body template and have Angular compile it, then inject it into the DOM's body element
      Meteor.startup(()->
        # Necessary?
        Spark.finalize(document.body)
        $('body').html($compile(bodyTemplate())($rootScope))
        $rootScope.$apply()
      )
  ])
  angular.module 'ngMeteor', ['ngMeteor.blade', 'ngMeteor.services', 'ngMeteor.directives']
)
