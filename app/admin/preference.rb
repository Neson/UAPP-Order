ActiveAdmin.register_page "Preference" do
  menu priority: 2
  content do

    form :action => admin_preference_update_path, :method => :post do |f|
      f.input :name => 'authenticity_token', :type => :hidden, :value => form_authenticity_token.to_s
      panel "Preference" do
        fieldset do
          ol do

            li do
              label '商品目錄頁首文字'
              f.textarea :name => "data[products_head]" do
                Preference.products_head
              end
            end

            li do
              label '繳款資料'
              f.textarea :name => "data[payment_info]" do
                Preference.payment_info
              end
            end

            li do
              label '購買須知'
              f.textarea :name => "data[order_notice]" do
                Preference.order_notice
              end
            end

            li do
              label '購買前同意事項'
              f.textarea :name => "data[order_consent]" do
                Preference.order_consent
              end
            end

            li do
              label '訂單自定欄位一：名稱 (留白表示停用)'
              f.input :name => "data[order_custom_column_1_name]", :type => 'text', :value => Preference.order_custom_column_1_name
            end

            li do
              label '訂單自定欄位一：選項 (格式為 JSON 陣列，留白表示自由填寫)'
              f.textarea :name => "data[order_custom_column_1_options]" do
                Preference.order_custom_column_1_options
              end
            end

            li do
              label '訂單自定欄位二：名稱 (留白表示停用)'
              f.input :name => "data[order_custom_column_2_name]", :type => 'text', :value => Preference.order_custom_column_2_name
            end

            li do
              label '訂單自定欄位二：選項 (格式為 JSON 陣列，留白表示自由填寫)'
              f.textarea :name => "data[order_custom_column_2_options]" do
                Preference.order_custom_column_2_options
              end
            end

            li do
              label 'Tag 搜尋 placeholder'
              f.input :name => "data[tag_filter_placeholder]", :type => 'text', :value => Preference.tag_filter_placeholder
            end

            li do
              label '訂購開始時間 (格式: 2100-07-02 08:00) (留白表示不限制)'
              f.input :name => "data[order_starttime]", :type => 'text', :value => Preference.order_starttime
            end

            li do
              label '訂購截止時間 (格式: 2100-07-02 08:00) (留白表示不限制)'
              f.input :name => "data[order_deadline]", :type => 'text', :value => Preference.order_deadline
            end

          end
        end
      end
      f.input :type => 'submit', :value => '更新'
    end
  end

  page_action :update, :method => :post do
    params['data'].each do |k, v|
      Preference[k] = v
    end
    redirect_to :back, :notice => "設定已更新"
  end
end
