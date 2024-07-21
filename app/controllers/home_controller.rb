class HomeController < ApplicationController
  include Phonelib

  def new
    number = params[:search_number]
    @phone_info = parse_phone_number(number) if number.present?
  end

  def create
  end

  def show
  end

  def destroy
  end

  private

  def parse_phone_number(number)
    # تحويل الأرقام العربية إلى أرقام إنجليزية
    number = convert_arabic_numbers_to_english(number)

    # التحقق من أن الرقم يحتوي فقط على أرقام إنجليزية
    unless valid_english_number?(number)
      return { error: 'The phone number contains non-English digits.' }
    end

    phone = Phonelib.parse('+966' + number)
    {
      number: phone.full_e164,
      country: phone.country,
      full_country: phone.full_country,
      type_number: phone.type,
      types: phone.types,
      carrier: phone.carrier,
      time_zone: phone.timezone,
      geo_name: phone.geo_name,
      valid: phone.valid?,
      possible: phone.possible?,
      valid_for_country: phone.valid_for_country?(phone.country),
      voice: phone.voice?,
      sms: phone.sms?,
      emergency: phone.emergency?,
      premium_rate: phone.premium_rate?,
      toll_free: phone.toll_free?,
      shared_cost: phone.shared_cost?,
      personal_number: phone.personal_number?,
      voip: phone.voip?,
      pager: phone.pager?,
      uan: phone.uan?,
      voicemail: phone.voicemail?,
      national: phone.national,
      international: phone.international,
      e164: phone.e164,
      raw_national: phone.raw_national,
      raw_international: phone.raw_international,
      raw_e164: phone.raw_e164
    }
  end

  def convert_arabic_numbers_to_english(number)
    number.tr('٠١٢٣٤٥٦٧٨٩', '0123456789')
  end

  def valid_english_number?(number)
    number.match?(/\A[0-9]+\z/)
  end
end
