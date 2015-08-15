-- Copyright (c) 2015, Rowanto Rowanto <rowanto@gmail.com>
--
-- Permission to use, copy, modify, and distribute this software for any
-- purpose with or without fee is hereby granted, provided that the above
-- copyright notice and this permission notice appear in all copies.
--
-- THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-- WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-- ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-- WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-- ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-- OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
--
-- $Id$

local tr = aegisub.gettext

script_name = tr"Select Missing Line"
script_description = tr"Select lines which are missing"
script_author = "Rowanto Rowanto"
script_version = "1"

function select_missing_line(subtitle, selected, active)

    local max_missing = 2000

    local last_line = nil
    local missing_lines = {}

    for subtitle_index,line_number in ipairs(selected) do
        --Read in the line
        local line = subtitle[line_number]

        --Check the length if not null
        if last_line then
            local missing_time = line.start_time - last_line.end_time

            if missing_time > max_missing then
                table.insert(missing_lines, line_number)
                table.insert(missing_lines, line_number - 1)
            end
        end

        last_line = line
    end

    return missing_lines
end

aegisub.register_macro(script_name, script_description, select_missing_line)