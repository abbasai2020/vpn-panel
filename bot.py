import os
from telegram import InlineKeyboardButton, InlineKeyboardMarkup, Update
from telegram.ext import Application, CommandHandler, CallbackQueryHandler, ContextTypes
import utils

TOKEN = os.getenv("BOT_TOKEN", "")

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    keyboard = [
        [InlineKeyboardButton("⚡ Reality", callback_data="reality")],
        [InlineKeyboardButton("🔥 Hysteria2", callback_data="hysteria2")],
        [InlineKeyboardButton("🚀 TUIC", callback_data="tuic")],
        [InlineKeyboardButton("🔑 Outline", callback_data="outline")]
    ]
    await update.message.reply_text("🌐 انتخاب کنید:", reply_markup=InlineKeyboardMarkup(keyboard))

async def button(update: Update, context: ContextTypes.DEFAULT_TYPE):
    query = update.callback_query
    await query.answer()
    if query.data == "reality":
        cfg, qr = utils.create_reality_config("tguser")
        await query.message.reply_text(f"Reality Config:\n`{cfg}`", parse_mode="Markdown")
    elif query.data == "hysteria2":
        cfg, qr = utils.create_hysteria2_config("tguser")
        await query.message.reply_text(f"Hysteria2 Config:\n`{cfg}`", parse_mode="Markdown")
    elif query.data == "tuic":
        cfg, qr = utils.create_tuic_config("tguser")
        await query.message.reply_text(f"TUIC Config:\n`{cfg}`", parse_mode="Markdown")
    elif query.data == "outline":
        api_url = os.getenv("OUTLINE_API_URL")
        cert = os.getenv("OUTLINE_API_CERT_SHA256")
        key, qr = utils.create_outline_key(api_url, cert)
        await query.message.reply_text(f"Outline Key:\n{key}")

def main():
    app = Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CallbackQueryHandler(button))
    app.run_polling()

if __name__ == "__main__":
    main()
