var ucf = function () {
  
  var enhanceTabs = function () {
    $("#tabs li a").each(function () {
        $(this).click(function () {
          $(".tab").hide();
          var id = $(this).attr("data-tab-id");
          $("#" + id).show();
          return false;
        });
    });
  };
  
  var alignButtons = function () {
    var $uf = $("#update-footprint");   
    var ufot = $uf.offset().top;
    
    var $cw = $("#checkout-wrapper");    
    var cwot = $cw.offset().top;
    
    if (cwot < ufot) {
      var fpot = $("#footprint").offset().top;
      var fpHeight = $("#footprint").outerHeight(true);
      var m = ufot - (fpot + fpHeight);
      $cw.css("margin-top", m);
    } else {
      var fcHeight = $("#footprint-col").outerHeight(true);
      var bm = parseInt($("#checkout-wrapper").css("margin-bottom"), 10);
      var ufHeight = $uf.height();
      var fudgeFactor = 5; // determined indirectly by top of right-col
      var top = fcHeight + fudgeFactor - ufHeight - bm;
      
      $uf.css("top", top);
    }
    
    // $("#jargon-buster").height($("#content").height());
  };
  
  var enableTooltips = function () {
    $("#footprint .num[title]").tooltip("#tooltip"); 
    $("#footprint .icon[title]").tooltip("#tooltip"); 
  };
  
  var autoSelectFlights = function () {
    $("#flight-tab input:radio").click(function () {
      var type = $(this).val().split("_")[0];
      if (type == "auto") {
        $("#flight_flight_class_one_off").attr("checked","checked");
      } else if (/^(short|long|domestic)$/.test(type)) {
        $("#flight_flight_class_multiple").attr("checked","checked");
      }
    });
    
    $("#flight-tab input:text").click(function () {
      $("#flight_flight_class_multiple").attr("checked","checked");
    });
    
    $("#flight-tab select").bind("change", function () {
      $("#flight_flight_class_one_off").attr("checked","checked");
    });
  };
  
  var autoSelectTransport = function () {
    $("#bus-fieldset input").click(function () {
      $("#transport_type_bus").attr("checked", "checked");
    });

    $("#train-fieldset input").click(function () {
      $("#transport_type_train").attr("checked", "checked");
    });
  };
  
  var visComp = function () {
    // All calculations assume the img height is half the width
    var avgPerson = 4.2;
    var avgFlight = 0.6;
    var imgWidth = 104;
        
    var calcVisData = function (n, avg, maxWidth) {
      var max = Math.max(avg, n);
      var min = Math.min(avg, n);      
      var maxArea = maxWidth * (maxWidth / 2);
      var minArea = (min * maxArea) / max;
      
      var minWidth = maxWidth;
      while (minWidth * (minWidth / 2) > minArea) minWidth--;
      
      return n >= max ? [maxWidth, minWidth] : [minWidth, maxWidth];
    };    
    
    var drawVisRef = function (usr, ref) {
      var width = imgWidth;
      var r = calcVisData(usr, ref, width);
      var usrW = r[0], refW = r[1];

      drawFeet(usrW, refW);      
      drawFlightFoot(refW);
    };
    
    var drawFlightFoot = function (refW) {
      var fw = calcVisData(avgFlight, avgPerson, refW)[0];
      $("#flight-footprint img").width(fw).height(fw / 2);
    };
    
    var drawFeet = function (usrW, refW) {
      $("#usr-footprint img").width(usrW).height(usrW / 2);
      $("#ref-footprint img").width(refW).height(refW / 2);
    };
    
    return {
      launch : function () {
        if ($("#footprint-comp").length == 1) {
          drawVisRef(ucf.data.userCo2, avgPerson);
        }
      }
    };
  }();
  
  var promptOnClear = function () {
    $("#clear").click(function () {
      if (!window.confirm("Clear your profile?")) {
        return false;
      }
    });
  };
  
  var enableAmountLabel = function () {
    $("#amount").bind("focus", function () {
      if ($(this).val() == "amount") {
        $(this).val("").removeClass("placeholder");
      }
    });
    $("#amount").bind("blur", function () {
      if ($.trim($(this).val()) == "") $(this).val("amount").addClass("placeholder");
    })
  };
  
  var validateOnConfirm = function () {
    $("#donate-form").submit(function () {
      var val = $("#amount").val();
      var valid = /^\d+(\.\d{2})?$/.test(val);
      if (!valid) {
        $("#amount-error").show().text("Please enter a valid amount - " + val + " isn't valid.");
      }
      return valid;
    });
  }
    
  return {

    launch: function () {
      // enhanceTabs();
      
      alignButtons();
      enableTooltips();
      autoSelectFlights();
      autoSelectTransport();   
      
      enableAmountLabel();
      promptOnClear();   
      
      validateOnConfirm();
      
      visComp.launch();      
    },
    
    data : {}
    
  };
  
}();
