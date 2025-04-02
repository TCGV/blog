---
layout: post
title: "Anecdotal evidence of increased coding productivity with AI"
date: 2025-04-02 10:55:00 -0300
tags: ai testing
---

I have been using AI to help me code (and actually to help me do anything) for a couple of years now. More and more I keep seeing how it boosts my productivity.

When programming, I keep code suggestions minimal in the IDE and really like the chat interface for tackling coding tasks. Writing down the problem, its constraints, and the task goals in a structured way has, in my experience, shown really great results and visibly boosted my productivity. As a bonus, it has positively influenced the way I communicate about technical challenges with colleagues.

So today, I saved some time to share a simple example — the anecdotal evidence. My task was to implement the following feature in a section of our app:

* Automatically compress uploaded images

It took <b>25 minutes</b> from start to finish. If I hadn't used AI, I estimate that it would have taken me about <b>2 hours</b> to search references, write down the code, test, and review before finishing this task.

Here's a quick overview of how I structured my workflow using ChatGPT (GPT-4o model):

1. <b>Define the Problem Clearly:</b> I started by clearly defining my task, which was to compress uploaded images automatically.
1. <b>Generate Code:</b> I asked ChatGPT to create a method for compressing images to high-quality JPEG, providing contextual code from my existing project.
1. <b>Integrate Changes:</b> Next, I requested ChatGPT to modify two existing image upload methods, incorporating the new compression method.
1. <b>Create Unit Tests:</b> Lastly, I asked ChatGPT to write a unit test for the new compression functionality following existing testing styles in the project.

Let's take a deep dive.

The Workflow in Detail
======

The first step was to check the source code, locate the image upload entry points, and find out whether the project defined a method to compress images to JPEG. I concluded that it didn't. So, my first prompt to ChatGPT was for it to create one, passing along additional contextual information so that the generated code would be compatible with my project:

<div style="padding: 10px;background-color: #f8f8f8;margin: 20px 0;" markdown="1">

In C# I'm using the following code for resizing images:

```csharp
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;

public static Image Resize(this Image image, int newWidth, int newHeight, string url = null) 
{
    using (var newImage = new Bitmap(newWidth, newHeight))
    {
        foreach (var item in image.PropertyItems)
            newImage.SetPropertyItem(item);

        using (var graphics = Graphics.FromImage(newImage))
        {
            graphics.SmoothingMode = SmoothingMode.AntiAlias;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
            graphics.DrawImage(image, new Rectangle(0, 0, newWidth, newHeight));
            var format = url != null ? GetImageFormat(url) : image.RawFormat;
            return Image.FromStream(newImage.ToStream(format));
        }
    }
}
```

Using the same referenced namespaces, how can I define a method for compressing images?

I want to compress PNG images into JPEG with high quality.

</div>

In its response ChatGPT correctly produced the following method (I'm omitting additional information and the usage sample also returned by ChatGPT):

```csharp
public static Image CompressToJpeg(this Image image, long quality = 90L)
{
    if (image == null) throw new ArgumentNullException(nameof(image));

    // Set JPEG quality encoder
    var jpegEncoder = ImageCodecInfo.GetImageDecoders()
        .FirstOrDefault(c => c.FormatID == ImageFormat.Jpeg.Guid);

    if (jpegEncoder == null)
        throw new InvalidOperationException("JPEG encoder not found");

    var encoderParams = new EncoderParameters(1);
    encoderParams.Param[0] = new EncoderParameter(Encoder.Quality, quality);

    using (var ms = new MemoryStream())
    {
        image.Save(ms, jpegEncoder, encoderParams);
        return Image.FromStream(new MemoryStream(ms.ToArray()));
    }
}
```

I skimmed through the code, and it seemed to implement everything I requested, so I continued by asking ChatGPT to use this code to adjust two of my application user flows:

<div style="padding: 10px;background-color: #f8f8f8;margin: 20px 0;" markdown="1">

Now consider these two methods which handle `Image` objects:


```csharp
    private string SaveCover(string coverName, Stream coverStream)
    {
        var path = GenerateImageName("covers", coverName);
        using (var img = Image.FromStream(coverStream))
        using (var stream = img.ToStream())
            return store.SaveObject(stream, path);
    }

    private string SaveIcon(string iconName, Stream iconStream)
    {
        var path = GenerateImageName("icons", iconName);
        using (var img = Image.FromStream(iconStream))
        using (var stream = img.ToStream())
            return store.SaveObject(stream, path);
    }
```

1. Check if the file name indicates that the image is PNG (or other uncompressed image file).
2. In case it is, call `CompressToJpeg()` and replace the name extensions to `.jpeg`.

</div>

As a result, both methods were modified as requested, and ChatGPT proposed a helper method `IsUncompressedImage` to be used by both methods in accordance with the DRY ("don't repeat yourself") principle.

Here's the final code for one of the methods after the introduced changes:

```csharp
private string SaveIcon(string iconName, Stream iconStream)
{
    var isUncompressed = IsUncompressedImage(iconName);

    var finalName = isUncompressed
        ? Path.ChangeExtension(iconName, ".jpeg")
        : iconName;

    var path = GenerateImageName("icons", finalName);

    using (var img = Image.FromStream(iconStream))
    {
        var processedImage = isUncompressed ? img.CompressToJpeg(90L) : img;
        using (var stream = processedImage.ToStream(ImageFormat.Jpeg))
        {
            return store.SaveObject(stream, path);
        }
    }
}
```

Again, I reviewed the code and was happy with the proposed changes. After pasting it into my application code, everything compiled without any issues.

Finally, before closing the code changes, I wanted to create a unit test for the new `CompressToJpeg` method, so I sent another message to ChatGPT to create the test analogous to another test in my project:

<div style="padding: 10px;background-color: #f8f8f8;margin: 20px 0;" markdown="1">

Now, create a unit test for the "CompressToJpeg" method. Follow the style below:

```csharp
    [TestMethod]
    public void GetGeolocatedImageCoordinateTest()
    {
        var image = Image.FromFile(@"Resources\geolocated.jpg");
        var c = image.GetCoordinate();

        Assert.IsNotNull(c);
        Assert.AreEqual($"{-22.8939933776855}", $"{c.Latitude}");
        Assert.AreEqual($"{-43.1236000061035}", $"{c.Longitude}");
    }
```

The test should:
1. Load a @"Resources\Boots.png" image
2. Convert it to Jpeg
3. Assert that the compressed image size is less than 25% of the original image size

Don't save the compressed image to disk.

</div>

And voilà, the unit test was correctly created according to my request:

```csharp
[TestMethod]
public void CompressToJpegTest()
{
    var image = Image.FromFile(@"Resources\Boots.png");

    using (var originalStream = new MemoryStream())
    using (var compressedStream = new MemoryStream())
    {
        // Save original image as PNG to stream
        image.Save(originalStream, ImageFormat.Png);
        var originalSize = originalStream.Length;

        // Compress to JPEG and save to stream
        var compressed = image.CompressToJpeg(90L);
        compressed.Save(compressedStream, ImageFormat.Jpeg);
        var compressedSize = compressedStream.Length;

        // Assert that the compressed image is less than 25% of the original size
        Assert.IsTrue(compressedSize < originalSize * 0.25,
            $"Expected compressed size < 25% of original. Original: {originalSize}, Compressed: {compressedSize}");
    }
}
```

After pasting the new test method into my test class, I was able to quickly run it and confirm that it passed 🟢.

Once I finished the code changes, I performed a manual test to validate that the task was completed:

<p align="center">
  <img style="max-height: 240px; max-width: 100%; margin: 10px 0" src="{{ site.baseurl }}/images/p36/upload-request.png" alt="Upload request in Chrome's network tab"/>
  <br><label style="font-size: 12px;">Figure 1. Upload request in Chrome's network tab</label>
</p>

Wrapping Up
======

Several studies try to capture how much productivity AI tools can bring. At the end of the day, it all depends on how frequently and how well you use them in your workflows.

As with anything, usage brings experience, and we become better at identifying the best situations and strategies for extracting productivity from these tools. A naive approach of blindly using AI in everything may backfire.

---

My complete conversation with ChatGPT can be accessed in the link below:

* https://chatgpt.com/share/67ed2912-af88-800b-835c-c0e0703a617f