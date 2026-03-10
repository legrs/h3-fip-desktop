require 'cairo' 

function conky_main()
    if conky_window == nil then return end
    
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    
    local mem_pct = tonumber(conky_parse("${memperc}"))
    local cpu_pct = tonumber(conky_parse("${cpu}"))
    local sto_pct = tonumber(conky_parse("${fs_used_perc /}"))
    local time = conky_parse("${time %H:%M:%S}")
    local timestamp = tonumber(conky_parse("${exec date +%s}"))

    --local screen_size = conky_parse("${desktop_resolution}")
    --local screen_x,screen_y = screen_size:match("(%d+)x(%d+)")
    --screen_x, screen_y = tonumber(screen_x), tonumber(screen_y)
    local screen_x = conky_window.width
    local screen_y = conky_window.height

    local radius = 6

    local sec1_x = 30
    local sec2_x = 300
    local sec3_x = 560
    local b1_x = 1200
    local b2_x = 1350
    local b3_x = 1600
    local sec_y = 80
    local f1 = 25
    local f2 = 20
    local f3 = 40
    local f4 = 60
    local value_ofs = 150
    local bar_x = 130
    local sec_h = f1+f2+5
    local text_color = 0.4
    local timeline_y = 200
    local rect_x = 100
    local rect_y = 50
    local w = 150
    local o = 5
    local freq = 30 -- sec
    
    cairo_select_font_face(cr, "sans-serif", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)

    -- name
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f1)
    cairo_move_to(cr, sec1_x, sec_y+f1)
    cairo_show_text(cr, "MEMORY")

    -- unit
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, sec1_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "%")

    -- value
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_font_size(cr, f3)
    cairo_move_to(cr, sec1_x+value_ofs, sec_y+(2*sec_h-f3) / 2)
    cairo_show_text(cr, mem_pct)


    -- bar
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec1_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec1_x+bar_x, sec_y)
    cairo_stroke(cr)
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec1_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec1_x+bar_x, sec_y+sec_h - (sec_h*mem_pct)/100)
    cairo_stroke(cr)


    -- name
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f1)
    cairo_move_to(cr, sec2_x, sec_y+f1)
    cairo_show_text(cr, "CPU")

    -- unit
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, sec2_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "%")

    -- value
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_font_size(cr, f3)
    cairo_move_to(cr, sec2_x+value_ofs, sec_y+(2*sec_h-f3) / 2)
    cairo_show_text(cr, cpu_pct)


    -- bar
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec2_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec2_x+bar_x, sec_y)
    cairo_stroke(cr)
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec2_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec2_x+bar_x, sec_y+sec_h - (sec_h*cpu_pct)/100)
    


    -- name
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f1)
    cairo_move_to(cr, sec3_x, sec_y+f1)
    cairo_show_text(cr, "STORAGE")

    -- unit
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, sec3_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "%")

    -- value
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_font_size(cr, f3)
    cairo_move_to(cr, sec3_x+value_ofs, sec_y+(2*sec_h-f3) / 2)
    cairo_show_text(cr, sto_pct)


    -- bar
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec3_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec3_x+bar_x, sec_y)
    cairo_stroke(cr)
    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_set_line_width(cr, 5)
    cairo_move_to(cr, sec3_x+bar_x, sec_y+sec_h)
    cairo_line_to(cr, sec3_x+bar_x, sec_y+sec_h - (sec_h*sto_pct)/100)
    cairo_stroke(cr)
    

    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b1_x, sec_y+f1)
    cairo_show_text(cr, "COMPUTER")

    cairo_set_source_rgba(cr, 1, 1, 1, 0.7)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b1_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "CF-SZ6")

    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b2_x, sec_y+f1)
    cairo_show_text(cr, "OPERATING SYSTEM")

    cairo_set_source_rgba(cr, 1, 1, 1, 0.7)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b2_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "LINUX MINT 21")

    cairo_set_source_rgba(cr, 1, 1, 1, text_color)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b3_x, sec_y+f1)
    cairo_show_text(cr, "USER NAME")

    cairo_set_source_rgba(cr, 1, 1, 1, 0.7)
    cairo_set_font_size(cr, f2)
    cairo_move_to(cr, b3_x, sec_y+sec_h - f2 + f1)
    cairo_show_text(cr, "LEGRS")

    -- time 
    cairo_set_source_rgba(cr, 1, 1, 1, 1)
    cairo_set_font_size(cr, f4)
    cairo_move_to(cr, screen_x/2 - 150, sec_y+(2*sec_h) / 2 + 10)
    cairo_show_text(cr, string.format("X+%s", time))


    -- timeline
    cairo_new_path(cr)
    local lg = cairo_pattern_create_linear(0, screen_x/2, screen_x)
    cairo_pattern_add_color_stop_rgba(lg, 0, 1, 1, 1, 0) 
    cairo_pattern_add_color_stop_rgba(lg, 0.6, 1, 1, 1, 1) 
    cairo_pattern_add_color_stop_rgba(lg, 1, 1, 1, 1, 0) 
    cairo_new_path(cr)
    cairo_set_line_width(cr, 3)
    cairo_move_to(cr, 0, timeline_y)
    cairo_line_to(cr, screen_x/2, timeline_y)
    cairo_set_source(cr, lg)
    cairo_stroke(cr)

    cairo_new_path(cr)
    lg = cairo_pattern_create_linear(0, screen_x/2, screen_x)
    cairo_pattern_add_color_stop_rgba(lg, 0, 1, 1, 1, 0) 
    cairo_pattern_add_color_stop_rgba(lg, 0.5, 1, 1, 1, 0.4) 
    cairo_pattern_add_color_stop_rgba(lg, 1, 1, 1, 1, 0) 
    cairo_new_path(cr)
    cairo_move_to(cr, screen_x/2, timeline_y)
    cairo_line_to(cr, screen_x, timeline_y)
    cairo_set_source(cr, lg)
    cairo_stroke(cr)

    cairo_pattern_destroy(lg)

    cairo_new_path(cr)
    cairo_arc(cr, screen_x/2, timeline_y, radius, 0, 2 * math.pi)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_fill(cr)

    local i = 0
    local delta = timestamp%freq /freq * w
    print(delta)
    while w*(i-1)<=screen_x do
        local x = i*(w+o)-delta
        cairo_new_path(cr)
        cairo_set_source_rgba(cr, 1,1,1,1)
        if x <= screen_x/2 then
            cairo_set_source_rgba(cr, 0,0,0,1)
        end

        cairo_set_line_width(cr, 3)
        cairo_move_to(cr, x, timeline_y)
        cairo_line_to(cr, x + o, timeline_y)
        cairo_stroke(cr)
        i = i+1
    end



    cairo_new_path(cr)
    cairo_set_source_rgba(cr, 1,1,1,1)
    cairo_rectangle(cr, screen_x-rect_x-50,90,rect_x,rect_y)
    cairo_fill(cr)

    cairo_set_source_rgba(cr, 0, 0, 0, 1)
    cairo_set_font_size(cr, 30)
    cairo_move_to(cr, screen_x-rect_x-33, 128)
    cairo_show_text(cr, "LIVE")

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end
