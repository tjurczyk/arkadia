
function scripts.utils.hex_to_rgb (hex) 
	local r, g, b = hex:match("#?(%w%w)(%w%w)(%w%w)")
	r = (tonumber(r, 16) or 0) / 255
	g = (tonumber(g, 16) or 0) / 255
	b = (tonumber(b, 16) or 0) / 255
	return r, g, b
end

function scripts.utils.rgb_to_hex(r, g, b)
	return string.format("#%.2X%.2X%.2X", 255*r, 255*g, 255*b)
end


function scripts.utils.saturate_hex(hex, amount)
   local r,g,b = scripts.utils.hex_to_rgb(hex)
   local h,s,l = scripts.utils.rgb_to_hsl(r, g, b)
 
   if amount < 0 then
     s = s + (s * amount)
   else
     s = s + ((1-s) * amount)
   end
   s = math.max(0, math.min(1, s))
   
   r,g,b = scripts.utils.hsl_to_rgb(h, s, l)
   return scripts.utils.rgb_to_hex(r, g, b)
end

function scripts.utils.lighten_hex(hex, amount)
   local r,g,b = scripts.utils.hex_to_rgb(hex)
   local h,s,l = scripts.utils.rgb_to_hsl(r, g, b)

   l = l + ((1-l) * amount)
   l = math.max(0, math.min(1, l))
   
   r,g,b = scripts.utils.hsl_to_rgb(h, s, l)
   return scripts.utils.rgb_to_hex(r, g, b)
end

function scripts.utils.darken_hex(hex, amount) 
   return scripts.utils.lighten_hex(hex, -amount)
end

function scripts.utils.hsl_to_rgb(h, s, l)
   h = h/360
   local m1, m2
   if l <= 0.5 then 
      m2 = l *(s+1)
   else 
      m2 = l+s-l*s
   end
   m1 = l*2-m2

   local function _h2rgb(m1, m2, h)
      if h<0 then h = h+1 end
      if h>1 then h = h-1 end
      if h*6<1 then 
         return m1+(m2-m1)*h*6
      elseif h*2<1 then 
         return m2 
      elseif h*3<2 then 
         return m1+(m2-m1)*(2/3-h)*6
      else
         return m1
      end
   end

   return _h2rgb(m1, m2, h+1/3), _h2rgb(m1, m2, h), _h2rgb(m1, m2, h-1/3)
end

function scripts.utils.rgb_to_hsl(r, g, b)
      --r, g, b = r/255, g/255, b/255
   local min = math.min(r, g, b)
   local max = math.max(r, g, b)
   local delta = max - min

   local h, s, l = 0, 0, ((min+max)/2)

   if l > 0 and l < 0.5 then s = delta/(max+min) end
   if l >= 0.5 and l < 1 then s = delta/(2-max-min) end

   if delta > 0 then
      if max == r and max ~= g then h = h + (g-b)/delta end
      if max == g and max ~= b then h = h + 2 + (b-r)/delta end
      if max == b and max ~= r then h = h + 4 + (r-g)/delta end
      h = h / 6;
   end

   if h < 0 then h = h + 1 end
   if h > 1 then h = h - 1 end

   return h * 360, s, l
end

function scripts.utils.color_gradient_calculate_steps(start_color, end_color, steps)
   local color_steps = {}
   local r1, g1, b1 = scripts.utils.hex_to_rgb(start_color)
   local r2, g2, b2 = scripts.utils.hex_to_rgb(end_color)
   local x = 1
   for i = 1, steps do
     local p = (i - 1) / (steps - 1)
     local r = (1.0 - p) * r1 + p * r2
     local g = (1.0 - p) * g1 + p * g2
     local b = (1.0 - p) * b1 + p * b2
     color_steps[i] = scripts.utils.rgb_to_hex(r, g, b)
   end
   return color_steps
 end