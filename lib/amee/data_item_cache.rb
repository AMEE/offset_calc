module AMEE

  class DataItemCache
    
    def self.development key
      {
        "/transport/plane/generic/auto_one_way" => "E98F73AE9B40",
        "/transport/plane/generic/auto_return" => "601248F5F793",
        "/transport/plane/generic/domestic" => "AD63A83B4D41",
        "/transport/plane/generic/domestic_one_way" => "FFC7A05D54AD",
        "/transport/plane/generic/domestic_return" => "F5498AD6FC75",
        "/transport/plane/generic/long_haul" => "7D4220DF72F9",
        "/transport/plane/generic/long_haul_one_way" => "46117F6C0B7E",
        "/transport/plane/generic/long_haul_return" => "96D538B1B246",
        "/transport/plane/generic/short_haul" => "9DA419052FDF",
        "/transport/plane/generic/short_haul_one_way" => "84B4A14C7424",
        "/transport/plane/generic/short_haul_return" => "8DA1BEAA1013",
        "/transport/car/generic/average_average" => "E57D6E2828EB",
        "/transport/car/generic/cng_large" => "9B1BDFE5E16D",
        "/transport/car/generic/cng_medium" => "FE331E5CFAAC",
        "/transport/car/generic/diesel_large" => "4F6CBCEE95F7",
        "/transport/car/generic/diesel_medium" => "7E2B2426C927",
        "/transport/car/generic/diesel_small" => "57E6AC080BF4",
        "/transport/car/generic/lpg_large" => "8EF8F1A1AB35",
        "/transport/car/generic/lpg_medium" => "CD299C7A24D6",
        "/transport/car/generic/petrol_large" => "CEA465039777",
        "/transport/car/generic/petrol_medium" => "9A9E8852220B",
        "/transport/car/generic/petrol_small" => "66DB66447D2F",
        "/transport/car/generic/petrol_hybrid_large" => "69A44DCA9845",
        "/transport/car/generic/petrol_hybrid_medium" => "7DC4C91CD8DA",
        "/home/energy/quantity/biodiesel" => "878854C275BC",
        "/home/energy/quantity/biomass" => "CFA7F3896189",
        "/home/energy/quantity/coal" => "A70149AF0F26",
        "/home/energy/quantity/coking_coal" => "0093104E595C",
        "/home/energy/quantity/diesel" => "D6C9BC81155D",
        "/home/energy/quantity/electricity" => "CDC2A0BA8DF3",
        "/home/energy/quantity/gas" => "66056991EE23",
        "/home/energy/quantity/gas_gross_CV" => "67D147AF530B",
        "/home/energy/quantity/kerosene" => "C024BCE859BB",
        "/home/energy/quantity/lpg" => "26709055568C",
        "/home/energy/quantity/oil" => "759D972FA239",
        "/home/energy/quantity/petrol" => "BE0B615B0316",
        "/home/energy/uk/price/biomass" => "2F85FDCA3E4C",
        "/home/energy/uk/price/coal" => "9960BAB8A79E",
        "/home/energy/uk/price/coking_coal" => "516BF51EBC4C",
        "/home/energy/uk/price/electricity_direct_debit" => "B5A1C5D76C69",
        "/home/energy/uk/price/electricity_normal" => "86401B790B86",
        "/home/energy/uk/price/electricity_prepayment" => "BEEBED50A5FC",
        "/home/energy/uk/price/electricityE7_direct_debit" => "465B99943B11",
        "/home/energy/uk/price/electricityE7_normal" => "7FD1778485C5",
        "/home/energy/uk/price/electricityE7_prepayment" => "C5D39DB9E8F7",
        "/home/energy/uk/price/gas_direct_debit" => "75E34D0BB5FE",
        "/home/energy/uk/price/gas_normal" => "EF6D793BC54C",
        "/home/energy/uk/price/gas_prepayment" => "7E08E4883988",
        "/home/energy/uk/price/lpg" => "5F60794661F8",
        "/home/energy/uk/price/oil" => "B8FE32603E8D",
        "/transport/byDistance/freight/Plane_Long_haul" => "6EB9240D1E18",
        "/transport/byDistance/freight/Plane_Medium_haul" => "83F72B31FA6B",
        "/transport/byDistance/freight/Plane_Short_haul" => "746C43AE5A63",
        "/transport/byDistance/freight/Road_General" => "B8EB61E7758F",
        "/transport/byDistance/freight/Ship_Inland" => "21B595CDEEC2",
        "/transport/byDistance/freight/Ship_Marine" => "638738E4102C",
        "/transport/byDistance/freight/Train_Coal" => "A14955317023",
        "/transport/byDistance/freight/Train_Diesel" => "86128ACABC02",
        "/transport/byDistance/freight/Train_Electric" => "BB669F223070",
        "/transport/bus/generic/coach" => "AFF51515EBFE",
        "/transport/bus/generic/local" => "9F7EDABB89F8",
        "/transport/bus/generic/london" => "BF374F8256CA",
        "/transport/bus/generic/typical" => "BF80FEDD0A6A",
        "/transport/train/generic/international" => "ECDBE4B04E4E",
        "/transport/train/generic/local_rail" => "B21B18CCA5F5",
        "/transport/train/generic/national" => "EFB46D30C58C",
        "/transport/train/generic/tram" => "3193B2011F56",
        "/transport/train/generic/underground" => "297341C32ADC",
      }[key]
    end

    def self.test key
      development key
    end

    def self.staging key
      development key
    end
    
    def self.production key
      {
        "/transport/plane/generic/auto_one_way" => "8C676F53C182",
        "/transport/plane/generic/auto_return" => "335DF1002D48",
        "/transport/plane/generic/domestic" => "5CF2E792CFEA",
        "/transport/plane/generic/domestic_one_way" => "FEB95AA58511",
        "/transport/plane/generic/domestic_return" => "BBC71E3D62AC",
        "/transport/plane/generic/long_haul" => "ED90A347F97C",
        "/transport/plane/generic/long_haul_one_way" => "3A5653C510A8",
        "/transport/plane/generic/long_haul_return" => "11DF2EE50F9A",
        "/transport/plane/generic/short_haul" => "8EA6DCBDFF21",
        "/transport/plane/generic/short_haul_one_way" => "4AC9673E5AA8",
        "/transport/plane/generic/short_haul_return" => "64EFB1FB36EF",
        "/transport/car/generic/average_average" => "30C5C41B45DE",
        "/transport/car/generic/cng_large" => "735DC4D41F2D",
        "/transport/car/generic/cng_medium" => "BCFF130729DA",
        "/transport/car/generic/diesel_large" => "4F6CBCEE95F7",
        "/transport/car/generic/diesel_medium" => "7E2B2426C927",
        "/transport/car/generic/diesel_small" => "57E6AC080BF4",
        "/transport/car/generic/lpg_large" => "7E34107219F0",
        "/transport/car/generic/lpg_medium" => "F783E581A9D6",
        "/transport/car/generic/petrol_large" => "CEA465039777",
        "/transport/car/generic/petrol_medium" => "9A9E8852220B",
        "/transport/car/generic/petrol_small" => "66DB66447D2F",
        "/transport/car/generic/petrol_hybrid_large" => "69A44DCA9845",
        "/transport/car/generic/petrol_hybrid_medium" => "7DC4C91CD8DA",
        "/home/energy/quantity/biodiesel" => "878854C275BC",
        "/home/energy/quantity/biomass" => "CFA7F3896189",
        "/home/energy/quantity/coal" => "A70149AF0F26",
        "/home/energy/quantity/coking_coal" => "8982F4AD51BA",
        "/home/energy/quantity/diesel" => "D6C9BC81155D",
        "/home/energy/quantity/electricity" => "D20E0D8A4164",
        "/home/energy/quantity/gas" => "66056991EE23",
        "/home/energy/quantity/gas_gross_CV" => "72B64430E81B",
        "/home/energy/quantity/kerosene" => "C024BCE859BB",
        "/home/energy/quantity/lpg" => "26709055568C",
        "/home/energy/quantity/oil" => "759D972FA239",
        "/home/energy/quantity/petrol" => "BE0B615B0316",
        "/home/energy/uk/price/biomass" => "2F85FDCA3E4C",
        "/home/energy/uk/price/coal" => "9960BAB8A79E",
        "/home/energy/uk/price/coking_coal" => "7B41606ABF2D",
        "/home/energy/uk/price/electricity_direct_debit" => "0AE6D4F7CDC1",
        "/home/energy/uk/price/electricity_normal" => "86401B790B86",
        "/home/energy/uk/price/electricity_prepayment" => "BEEBED50A5FC",
        "/home/energy/uk/price/electricityE7_direct_debit" => "14A632BFDA7D",
        "/home/energy/uk/price/electricityE7_normal" => "110AB8ADAA63",
        "/home/energy/uk/price/electricityE7_prepayment" => "E886FDF52BC9",
        "/home/energy/uk/price/gas_direct_debit" => "B65E1849009D",
        "/home/energy/uk/price/gas_normal" => "EF6D793BC54C",
        "/home/energy/uk/price/gas_prepayment" => "7E08E4883988",
        "/home/energy/uk/price/lpg" => "5F60794661F8",
        "/home/energy/uk/price/oil" => "B8FE32603E8D",
        "/transport/byDistance/freight/Train_Coal" => "D933A03891E6",
        "/transport/byDistance/freight/Train_Diesel" => "F1F4841F4AE7",
        "/transport/byDistance/freight/Train_Electric" => "9ABABA9C3E02",
        "/transport/byDistance/freight/Road_General" => "3D29627DD0BD",
        "/transport/byDistance/freight/Ship_Inland" => "EA7E9F2C2061",
        "/transport/byDistance/freight/Plane_Long_haul" => "69246E5E4DAB",
        "/transport/byDistance/freight/Ship_Marine" => "3ACBDD6944BB",
        "/transport/byDistance/freight/Plane_Medium_haul" => "932E4DE7A8BC",
        "/transport/byDistance/freight/Plane_Short_haul" => "E5EB834734A8",
        "/transport/bus/generic/coach" => "947295AD548E",
        "/transport/bus/generic/local" => "43E6F92FE39E",
        "/transport/bus/generic/london" => "1DA7F013B8EB",
        "/transport/bus/generic/typical" => "BF80FEDD0A6A",
        "/transport/train/generic/international" => "70558E090544",
        "/transport/train/generic/local_rail" => "5EACF8DA7B21",
        "/transport/train/generic/national" => "39EC867D7E7D",
        "/transport/train/generic/tram" => "30FD5672F338",
        "/transport/train/generic/underground" => "0FAF9908F050",
      }[key]
    end

  end
  
end
