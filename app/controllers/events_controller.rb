# -*- coding: utf-8 -*-
class EventsController < ApplicationController
  active_scaffold :event do |conf|
    conf.columns = [:st, :desc, :source, :alerted]
    list.sorting = {:st => 'ASC'}
    columns[:st     ].label = "開始"
    columns[:desc   ].label = "詳細"
    columns[:source ].label = "入力者"
    columns[:alerted].label = "告知済"

    columns[:desc].options = { :cols => 80, :rows => 4 }
  end
end 
