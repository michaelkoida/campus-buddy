// functions/index.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const express = require("express");
const cors = require("cors");

// Initialize Admin SDK with full system privileges to modify Firestore data rows
admin.initializeApp();
const db = admin.firestore();

const app = express();

// Automatically handle security clearance policies for smooth traffic routing
app.use(cors({ origin: true }));
app.use(express.json());

// 🚀 PRODUCTION PAYSTACK WEBHOOK EVENT LISTENER INTERCEPT NODE
app.post("/paystack-webhook", async (req, res) => {
  const paymentEvent = req.body;

  // 1. Verify that the event coming in represents a fully authorized transaction completion
  if (paymentEvent && paymentEvent.event === "charge.success") {
    const customerEmail = paymentEvent.data.customer.email;
    
    // Fallback extraction points looking at custom metadata cells you attached inside Flutter
    const metadata = paymentEvent.data.metadata || {};
    const planPaidFor = metadata.custom_plan_type; // Expecting: "chat_extend", "seller_license", or "external_merchant"

    try {
      // 2. Query your multi-tenant user database table to locate the specific user by their email address
      const usersQuerySnapshot = await db.collection("users").where("email", "==", customerEmail).get();

      if (!usersQuerySnapshot.empty) {
        // Grab the precise document reference pointer for their profile row
        const userDocRef = usersQuerySnapshot.docs[0].ref;

        // 3. Systematically evaluate custom plan parameters and apply global database rights instantly
        if (planPaidFor === "chat_extend") {
          // Permanently elevate social limits tier across campus networks
          await userDocRef.update({ "isPremium": true });
          console.log(`✅ [Paystack Cloud Functions]: Chat limits completely cleared for student: ${customerEmail}`);
        } else if (planPaidFor === "seller_license") {
          // Open up student store marketplace publishing authorizations
          await userDocRef.update({ "hasSellerAccess": true });
          console.log(`✅ [Paystack Cloud Functions]: Student seller hub activated for user: ${customerEmail}`);
        } else if (planPaidFor === "external_merchant") {
          // Configure non-student vendor operations access privileges 
          await userDocRef.update({ 
            "hasSellerAccess": true,
            "isExternalBusiness": true 
          });
          console.log(`✅ [Paystack Cloud Functions]: 3-Month External Merchant node unlocked for vendor: ${customerEmail}`);
        }
      } else {
        console.log(`⚠️ [Paystack Cloud Functions Warning]: Transaction matched successful payment, but no matching email profile found in database table for: ${customerEmail}`);
      }
    } catch (error) {
      console.error("❌ [Database Error during execution sync]: ", error);
      return res.sendStatus(500); // Alert Paystack nodes that processing failed locally
    }
  }

  // Always return a 200 HTTP response code status to acknowledge receipt of the payment message data packet
  return res.sendStatus(200);
});

// Export Express microservice framework layer straight out into Google Cloud infrastructure
exports.api = functions.https.onRequest(app);
