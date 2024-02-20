#
# Copyright 2024- TODO: Write your name
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class PipeparseFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("pipeparse", self)

      config_param :key_name, :string

      def filter(tag, time, record)
        # パラメータとして指定したkey_nameの値を取得
        value = record[@key_name]

        # パイプで区切られた文字列を配列に変換
        values = value.split("|")

        values.each_with_index do |value_item, index|
          # value_itemが空白やnilの場合はスキップ
          next if value_item.nil? || value_item.empty?
          # key_name_0, key_name_1, key_name_2, ... というキー名で値を設定
          record["#{key_name}_#{index}"] = value_item
        end

        record
      end
    end
  end
end
