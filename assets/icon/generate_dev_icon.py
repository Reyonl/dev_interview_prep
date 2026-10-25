import math
import os
from PIL import Image, ImageDraw, ImageFont, ImageFilter

def hex_to_rgb(hex_str):
    hex_str = hex_str.lstrip('#')
    return tuple(int(hex_str[i:i+2], 16) for i in (0, 2, 4))

def blend(c1, c2, factor):
    return tuple(int(c1[i] + (c2[i] - c1[i]) * factor) for i in range(3))

def generate_dev_interview_icon(base_dir):
    target_size = 1024
    scale = 2  # 2048x2048 supersampled
    size = target_size * scale
    
    bg_top = hex_to_rgb("#090D16")
    bg_bot = hex_to_rgb("#141E33")
    accent_orange = hex_to_rgb("#FF8A3D")
    accent_emerald = hex_to_rgb("#10B981")
    text_white = (255, 255, 255)
    
    # ─── 1. FULL APP ICON ───────────────────────────────────────────────
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Background squircle with gradient
    margin = int(size * 0.04)
    radius = int(size * 0.22)
    bbox = [margin, margin, size - margin, size - margin]
    
    # Create gradient layer
    grad_img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    for y in range(margin, size - margin):
        factor = (y - margin) / float(size - 2 * margin)
        rgb = blend(bg_top, bg_bot, factor)
        row = Image.new("RGBA", (size - 2 * margin, 1), rgb + (255,))
        grad_img.paste(row, (margin, y))
        
    mask = Image.new("L", (size, size), 0)
    mask_draw = ImageDraw.Draw(mask)
    mask_draw.rounded_rectangle(bbox, radius=radius, fill=255)
    img.paste(grad_img, (0, 0), mask)
    
    # Elegant glowing border
    draw.rounded_rectangle(bbox, radius=radius, outline=accent_orange + (140,), width=int(scale * 8))
    
    # Outer ambient ring
    ring_margin = margin + int(size * 0.05)
    draw.rounded_rectangle(
        [ring_margin, ring_margin, size - ring_margin, size - ring_margin],
        radius=int(radius * 0.8),
        outline=(255, 255, 255, 18),
        width=int(scale * 3)
    )

    # Center Developer / Interview Emblem
    cx, cy = size / 2, size / 2
    
    # Terminal Prompt & Interview Speech Card
    card_w = size * 0.58
    card_h = size * 0.44
    card_r = int(scale * 36)
    card_box = [cx - card_w/2, cy - card_h/2 - size * 0.02, cx + card_w/2, cy + card_h/2 - size * 0.02]
    
    card_overlay = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    c_draw = ImageDraw.Draw(card_overlay)
    c_draw.rounded_rectangle(card_box, radius=card_r, fill=(15, 23, 42, 220), outline=accent_emerald + (180,), width=int(scale * 6))
    
    # Header bar of the code card (macOS/Terminal window dots)
    dot_y = card_box[1] + size * 0.045
    dot_r = int(scale * 12)
    c_draw.ellipse([card_box[0] + size * 0.045 - dot_r, dot_y - dot_r, card_box[0] + size * 0.045 + dot_r, dot_y + dot_r], fill=(239, 68, 68, 255))
    c_draw.ellipse([card_box[0] + size * 0.080 - dot_r, dot_y - dot_r, card_box[0] + size * 0.080 + dot_r, dot_y + dot_r], fill=(245, 158, 11, 255))
    c_draw.ellipse([card_box[0] + size * 0.115 - dot_r, dot_y - dot_r, card_box[0] + size * 0.115 + dot_r, dot_y + dot_r], fill=(16, 185, 129, 255))
    
    # Divider line in terminal
    c_draw.line(
        [(card_box[0] + int(scale * 6), dot_y + size * 0.035), (card_box[2] - int(scale * 6), dot_y + size * 0.035)],
        fill=(255, 255, 255, 25),
        width=int(scale * 3)
    )
    
    # Draw Code Prompt ">_" & Checkmark Badge
    # Terminal Arrow ">"
    arrow_x = card_box[0] + size * 0.08
    arrow_y = cy - size * 0.02
    arrow_len = size * 0.065
    arrow_th = int(scale * 12)
    c_draw.line([(arrow_x, arrow_y - arrow_len), (arrow_x + arrow_len * 1.1, arrow_y)], fill=accent_orange + (255,), width=arrow_th)
    c_draw.line([(arrow_x + arrow_len * 1.1, arrow_y), (arrow_x, arrow_y + arrow_len)], fill=accent_orange + (255,), width=arrow_th)
    
    # Cursor "_"
    cur_x = arrow_x + arrow_len * 1.6
    cur_y = arrow_y + arrow_len * 0.8
    c_draw.line([(cur_x, cur_y), (cur_x + size * 0.07, cur_y)], fill=text_white + (240,), width=arrow_th)
    
    # Text "DEV" & "PASS" emblem badge
    try:
        font_large = ImageFont.truetype("arialbd.ttf", int(scale * 62))
        font_sub = ImageFont.truetype("arialbd.ttf", int(scale * 34))
    except Exception:
        font_large = ImageFont.load_default()
        font_sub = ImageFont.load_default()
        
    c_draw.text((cur_x + size * 0.10, arrow_y - size * 0.045), "DEV", fill=text_white + (255,), font=font_large)
    
    # Floating Verified / Pass Interview Badge
    badge_cx = card_box[2] - size * 0.04
    badge_cy = card_box[3] - size * 0.02
    badge_r = int(size * 0.09)
    c_draw.ellipse([badge_cx - badge_r, badge_cy - badge_r, badge_cx + badge_r, badge_cy + badge_r], fill=accent_emerald + (255,), outline=(9, 13, 22, 255), width=int(scale * 8))
    
    # Checkmark inside badge
    chk_th = int(scale * 12)
    c_draw.line([(badge_cx - badge_r * 0.45, badge_cy), (badge_cx - badge_r * 0.1, badge_cy + badge_r * 0.35)], fill=(255, 255, 255, 255), width=chk_th)
    c_draw.line([(badge_cx - badge_r * 0.1, badge_cy + badge_r * 0.35), (badge_cx + badge_r * 0.45, badge_cy - badge_r * 0.35)], fill=(255, 255, 255, 255), width=chk_th)
    
    img = Image.alpha_composite(img, card_overlay)
    
    # Downsample Lanczos
    final_icon = img.resize((target_size, target_size), Image.Resampling.LANCZOS)
    app_icon_path = os.path.join(base_dir, "app_icon.png")
    final_icon.save(app_icon_path, "PNG")
    print(f"Generated {app_icon_path}")
    
    # ─── 2. ADAPTIVE BACKGROUND ─────────────────────────────────────────
    bg_img = Image.new("RGBA", (size, size), bg_top + (255,))
    bg_grad = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    for y in range(size):
        factor = y / float(size - 1)
        rgb = blend(bg_top, bg_bot, factor)
        row = Image.new("RGBA", (size, 1), rgb + (255,))
        bg_grad.paste(row, (0, y))
    bg_final = bg_grad.resize((target_size, target_size), Image.Resampling.LANCZOS)
    bg_path = os.path.join(base_dir, "app_icon_background.png")
    bg_final.save(bg_path, "PNG")
    print(f"Generated {bg_path}")
    
    # ─── 3. ADAPTIVE FOREGROUND (Scale to ~60% safe area) ───────────────
    fg_canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    fg_layer = card_overlay.resize((int(size * 0.72), int(size * 0.72)), Image.Resampling.LANCZOS)
    offset_x = (size - fg_layer.width) // 2
    offset_y = (size - fg_layer.height) // 2
    fg_canvas.paste(fg_layer, (offset_x, offset_y), fg_layer)
    
    fg_final = fg_canvas.resize((target_size, target_size), Image.Resampling.LANCZOS)
    fg_path = os.path.join(base_dir, "app_icon_foreground.png")
    fg_final.save(fg_path, "PNG")
    print(f"Generated {fg_path}")

if __name__ == "__main__":
    generate_dev_interview_icon(r"C:\Users\ThinkPad\Documents\antigravity\dev_interview_prep\assets\icon")
