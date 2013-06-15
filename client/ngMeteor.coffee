define("ngMeteor", [], ->
  angular.module('ngMeteor.directives', [])

  angular.module('ngMeteor.services', [])

  angular.module('ngMeteor.blade', []).run(['$templateCache', '$rootScope', '$compile',
    ($templateCache, $rootScope, $compile) ->
      bodyPartial = Template.body
      if !bodyPartial
        throw new Error("A body template must be defined ('body.blade')")

      $templateCache.put "#{key}.blade", render() for own key, render of Template

      # Re-render body compiling it for angular use
      Meteor.startup(()->
        # Necessary?
        Spark.finalize(document.body)
        $('body').html($compile(bodyPartial())($rootScope))
        do $rootScope.$apply
      )
  ])
  angular.module 'ngMeteor', ['ngMeteor.blade', 'ngMeteor.services', 'ngMeteor.directives']
)
