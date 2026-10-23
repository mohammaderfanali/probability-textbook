# راهنمای پروژهٔ جزوه

## ساختار پوشه

```
jalase01.tex, jalase02.tex, jalase03.tex   ← فایل اصلی هر جلسه (جلد + محتوای آن جلسه)
main.tex                                   ← جزوهٔ کامل (هر جلسه‌ای که \input شود)
dabirestan.tex + dabirestan/ch1…ch6.tex    ← جزوهٔ جداگانهٔ «احتمال به زبان ساده» برای دبیرستان
                                              (ساخت: build.ps1 dabirestan)
sessions/session01.tex … session03.tex     ← «متن» هر جلسه؛ ویرایش اصلی اینجاست
sessions/session04.tex                     ← احتمال شرطی، احتمال کل، بیز (برای جلسهٔ ۴، هنوز بازنویسی نشده)
sessions/session05.tex                     ← متغیر تصادفی، PMF، CDF، برنولی/دوجمله‌ای، متغیر نشانگر (جلسهٔ ۵)
sessions/session06.tex                     ← هندسی و بی‌حافظگی، پواسون و پیوندش با برنولی/دوجمله‌ای (جلسهٔ ۶)
sessions/session07.tex                     ← متغیر پیوسته، PDF، یکنواخت (جلسهٔ ۷)
sessions/session08.tex                     ← نمایی و بی‌حافظگی، گاوسی و تابع Φ، لاپلاس، کوشی، مقایسهٔ tail (جلسهٔ ۸)
sessions/session09.tex                     ← تابعی از متغیرهای تصادفی، امید ریاضی، خطی بودن، امید توزیع‌ها (جلسهٔ ۹)
sessions/session10.tex                     ← واریانس و ویژگی‌ها، چبیشف، واریانس توزیع‌ها، میانه و مد (جلسهٔ ۱۰)
sessions/_later_expect.tex                 ← کنار گذاشته برای بعد: فرمول tail، امید شرطی و امید کل، مارکوف، سن‌پترزبورگ، قانون اعداد بزرگ
sessions/_template.tex                     ← قالب آماده برای جلسهٔ جدید
config/        ← ظاهر: رنگ‌ها (colors)، قلم (fonts)، باکس‌ها (boxes)، دستورها (macros)
frontmatter/   ← جلد، پیشگفتار، منابع، جلد هر جلسه (session-cover)
images/        ← آرم دانشگاه
fonts/         ← قلم Estedad
pdf/           ← خروجی‌های نهایی
build/         ← فایل‌های موقت کامپایل (می‌شود پاکش کرد)
```

## ویرایش یک جلسه

1. متن را در `sessions/sessionNN.tex` تغییر دهید.
2. کامپایل کنید (یکی از دو راه زیر). PDF در `pdf/jalaseNN.pdf` ساخته می‌شود.

**VS Code:** پوشهٔ `jozve` را باز کنید؛ با هر ذخیره (`Ctrl+S`) خودش کامپایل می‌کند و `Ctrl+Alt+V` پیش‌نمایش را باز می‌کند.

**خط فرمان (در پوشهٔ jozve):**
```
powershell -ExecutionPolicy Bypass -File build.ps1 jalase02    ← فقط جلسهٔ ۲
powershell -ExecutionPolicy Bypass -File build.ps1 all         ← همهٔ جلسه‌ها
powershell -ExecutionPolicy Bypass -File build.ps1 main        ← جزوهٔ کامل
powershell -ExecutionPolicy Bypass -File build.ps1 clean       ← پاک کردن build/
```

## چیزهایی که معمولاً عوض می‌شوند

| می‌خواهید… | کجا |
|---|---|
| تاریخ، اهداف، منابع یک جلسه | `\sessioncard{...}` اول `sessions/sessionNN.tex` |
| عنوان و موضوعات روی جلد جلسه | `\sessioncover{...}` در `jalaseNN.tex` |
| نام دانشکده / درس / ترم | بالای `jalaseNN.tex` و `main.tex` |
| رنگ‌ها | `config/colors.tex` |
| قلم | `config/fonts.tex` |
| جلسه‌ها در جزوهٔ کامل | خط‌های `\input{sessions/...}` در `main.tex` |

## باکس‌ها

```latex
\begin{definition}{عنوان} ... \end{definition}
\begin{theorem}{عنوان} ... \end{theorem}      \begin{proof} ... \end{proof}
\begin{example}{عنوان} ... \begin{solution} ... \end{solution} \end{example}
\begin{note} ... \end{note}   \begin{warning} ... \end{warning}   \begin{intuition} ... \end{intuition}
\begin{moreinfo}{عنوان} ... \end{moreinfo}      ← «بیشتر بدانید»
\begin{exercise} ... \answer{جواب} \end{exercise}
```

## جلسهٔ جدید (مثلاً ۴)

1. `jalase03.tex` را به `jalase04.tex` کپی کنید و در آن: شماره و عنوان جلد، `\setcounter{chapter}{3}` و `\input{sessions/session04}` را عوض کنید.
2. خط اول `sessions/session04.tex` را `% !TEX root = ../jalase04.tex` کنید.

## نکته‌های راست‌به‌چپ

- عبارت فارسی داخل فرمول: `$\P(\fa{دقیقاً $k$ شیر})$` (نه `x\text{...}y`).
- عنوان یا پاراگراف را با فرمول شروع نکنید (مثلاً «$\sigma$-میدان …»)؛ یک کلمهٔ فارسی قبلش بگذارید.
- اعداد بزرگ در فرمول: `3{,}628{,}800` (نه `\,`).
- شکل‌ها: داخل `figblock` و زیرنویس با `\figcaption[label]{...}`.
